# MyStore Backend API

Base URL: `http://localhost:3000` (port configurable via `PORT` env var)

## Authentication

Some endpoints require authentication via the `Authorization` header:

```
Authorization: <user_id>
```

> Note: This implementation treats the raw `Authorization` header value directly as the `user_id`: there is no token verification/JWT decoding in this codebase. Any non-empty header value is accepted as the identity of the requesting user.

Requests to protected endpoints without an `Authorization` header receive:

```json
{ "message": "Authorization token is required" }
```

Status: `401 Unauthorized`

## Common Response Envelope

Successful responses (HTTP status codes **200–299**) are wrapped in the following format:

```json
{
  "data": ...
}
```

Error responses are returned in the following format:

```json
{
  "message": "Error description"
}
```

## Products

### `GET /products/hero`

Returns the "hero" product: the best-selling product (by total quantity across all orders), or the most recently created product if there are no orders yet.

- **Auth required:** No
- **Query params:** None
- **Body:** None

**Response `200 OK`**

```json
{
  "data": {
    /* Product */
  }
}
```

**Response `404 Not Found`** - if no products exist at all

```json
{ "message": "No products found" }
```

### `GET /products/featured`

Returns all products, ordered by id ascending.

- **Auth required:** No
- **Query params:** None
- **Body:** None

**Response `200 OK`**

```json
{
  "data": {
    "products": [
      /* Product */
    ]
  }
}
```

### `POST /products/bulk`

Returns products matching a list of ids.

- **Auth required:** No

**Body**

```json
{ "ids": ["1", "2", "3"] }
```

| Field | Type                   | Required | Notes                                                                      |
| ----- | ---------------------- | -------- | -------------------------------------------------------------------------- |
| `ids` | array of string/number | No       | Non-numeric ids are silently filtered out. If empty/omitted, returns `[]`. |

**Response `200 OK`**

```json
{
  "data": {
    "products": [
      /* Product */
    ]
  }
}
```

### `GET /products/mine`

Returns all products created by the authenticated user.

- **Auth required:** Yes (`Authorization` header)
- **Query params:** None
- **Body:** None

**Response `200 OK`**

```json
{
  "data": {
    "products": [
      /* Product */
    ]
  }
}
```

### `POST /products`

Creates a new product owned by the authenticated user.

- **Auth required:** Yes

**Body**

```json
{
  "name": "string",
  "description": "string",
  "price": { "amount": 19.99, "currency": "USD", "discount_percent": 0 },
  "image_url": "string"
}
```

| Field         | Type                                                             | Required |
| ------------- | ---------------------------------------------------------------- | -------- |
| `name`        | string                                                           | Yes      |
| `description` | string                                                           | Yes      |
| `price`       | Price object (`amount`, `currency`, optional `discount_percent`) | Yes      |
| `image_url`   | string                                                           | Yes      |

**Response `201 Created`**

```json
{
  "data": {
    /* Product */
  }
}
```

**Response `400 Bad Request`** — if any required field is missing/null

```json
{ "message": "Invalid product data" }
```

---

### `PUT /products/:id`

Updates a product. Only the creator of the product may update it. Fields omitted from the body are left unchanged (`price`, if provided, fully replaces the existing price record).

- **Auth required:** Yes

**Path params**
| Param | Type | Notes |
|---|---|---|
| `id` | numeric string | Product id |

**Body** (all optional — only provided fields are updated)

```json
{
  "name": "string",
  "description": "string",
  "price": { "amount": 24.99, "currency": "USD" },
  "image_url": "string"
}
```

**Response `200 OK`**

```json
{
  "data": {
    /* Product */
  }
}
```

**Response `404 Not Found`**

```json
{ "message": "Product not found" }
```

**Response `403 Forbidden`** — if the authenticated user is not the product's creator

```json
{ "message": "Permission denied" }
```

### `DELETE /products/:id`

Deletes a product. Only the creator may delete it.

- **Auth required:** Yes

**Path params**
| Param | Type | Notes |
|---|---|---|
| `id` | numeric string | Product id |

**Response `200 OK`**

```json
{ "data": null }
```

**Response `404 Not Found`**

```json
{ "message": "Product not found" }
```

**Response `403 Forbidden`**

```json
{ "message": "Permission denied" }
```

## Cart

### `GET /cart`

Returns the authenticated user's active cart. If none exists, one is created.

- **Auth required:** Yes
- **Query params:** None
- **Body:** None

**Response `200 OK`**

```json
{
  "data": {
    "cart": {
      /* Cart */
    }
  }
}
```

### `PATCH /cart/items`

Adds, updates, or removes an item in a cart.

- **Auth required:** Yes

**Body**

```json
{
  "cart_id": "1",
  "product_id": "2",
  "quantity": 3
}
```

| Field        | Type           | Required | Notes                                                                                                                                             |
| ------------ | -------------- | -------- | ------------------------------------------------------------------------------------------------------------------------------------------------- |
| `cart_id`    | numeric string | Yes      | Must belong to the authenticated user.                                                                                                            |
| `product_id` | numeric string | Yes      | Must reference an existing product when `quantity > 0`.                                                                                           |
| `quantity`   | integer        | Yes      | `0` or negative removes the item from the cart. Positive value adds/updates the item, snapshotting the product's _current_ price as `unit_price`. |

**Response `200 OK`**

```json
{
  "data": {
    "cart": {
      /* Cart, recalculated totals */
    }
  }
}
```

**Response `404 Not Found`**

```json
{ "message": "Cart not found" }
```

or (when `quantity > 0` and the product doesn't exist)

```json
{ "message": "Product not found" }
```

**Response `403 Forbidden`** — if the cart does not belong to the authenticated user

```json
{ "message": "Permission denied" }
```

## Orders

### `POST /orders`

Places an order from the authenticated user's active cart. Copies each cart item (with its currently-stored unit price) into new order line items, creates the order, and marks the cart `completed`.

- **Auth required:** Yes
- **Body:** None (order is built from the user's active cart)

**Response `201 Created`**

```json
{
  "data": {
    /* Order */
  }
}
```

**Response `400 Bad Request`** — if there is no active cart, or it is already completed

```json
{ "message": "Invalid cart" }
```

> Note: an empty active cart (no items) is not rejected — it will produce an order with an empty `line_items` array.

### `GET /orders`

Returns all orders placed by the authenticated user, ordered by id ascending.

- **Auth required:** Yes
- **Query params:** None
- **Body:** None

**Response `200 OK`**

```json
{
  "data": {
    "orders": [
      /* Order */
    ]
  }
}
```

## Error Handling

| Status | Meaning                                     | Example body                                       |
| ------ | ------------------------------------------- | -------------------------------------------------- |
| 400    | Bad request / validation error              | `{ "message": "Invalid product data" }`            |
| 401    | Missing `Authorization` header              | `{ "message": "Authorization token is required" }` |
| 403    | Authenticated user doesn't own the resource | `{ "message": "Permission denied" }`               |
| 404    | Resource not found, or unmatched route      | `{ "message": "Not found" }`                       |
| 500    | Unhandled server error                      | `{ "message": "Internal Server Error" }`           |

Any route not matching the ones above returns `404 Not Found` with `{ "message": "Not found" }`.

## Known Gaps / Caveats (for API consumers)

- **Authentication is not verified** — the `Authorization` header value is used directly as the user id, with no signature/token validation.
- `POST /orders` does not prevent placing an order on an empty cart.
- `product_id` in order line items is stored/returned as-is (not guaranteed numeric-string like elsewhere).
