# Learning Guide

This guide is written for someone who wants to **understand the code, not just run it**. You do not need to read every file. Follow one request at a time and connect the files as you go.

## The big picture

If the repository feels overwhelming, remember this one flow:

```text
request
  │
  ▼
router
  │
  ▼
middlewares (e.g. authentication, CORS)
  │
  ▼
controller
  │
  ▼
service
  │
  ▼
model
  │
  ▼
database (e.g. PostgreSQL)
  │
  ▼
response
```

This repository is designed to be read as a tutorial project, not only run as an API.

The fastest way to understand it is to follow one request all the way through the stack and then compare v1 with v2.

## What you will learn

By working through the project, you can study:

- versioned REST APIs and shared route implementations
- the separation between routes, controllers, services, and models
- PostgreSQL queries with parameters instead of string-built SQL
- multi-step database transactions
- schema changes with migrations
- authentication middleware
- Google ID token verification and application JWTs
- Docker-based development and deployment concepts

The goal is not to memorize this repository. The goal is to recognize the same boundaries when you encounter a different backend codebase.

## Recommended order

### 1. Start with the application composition

**Goal:** understand where the application is assembled before reading individual features.

Read:

```text
src/app.js
src/server.js
```

Learn the difference between:

- creating/configuring an Express application;
- connecting to PostgreSQL;
- starting the HTTP server;
- registering middleware and routes.

The key observation is in `app.js`: the same route factories are mounted twice with different authentication middleware.

### 2. Pick one simple public endpoint

**Goal:** learn the route -> controller -> service -> model flow without authentication getting in the way.

Start with:

```http
GET /api/v1/products/featured
```

Trace:

```text
app.js
  -> routes/products.js
  -> products.controller.js
  -> product.service.js
  -> models/Product.js
  -> PostgreSQL
```

There is no authentication on this path, so it is the cleanest introduction to the architecture.

### 3. Learn the response envelope

Successful responses look like:

```json
{
  "data": {
    "products": []
  }
}
```

Errors look like:

```json
{
  "message": "Product not found"
}
```

This gives clients a predictable top-level response shape.

### 4. Follow a protected request

**Goal:** understand how a request gets an authenticated user ID before business logic runs.

Choose whichever authentication path you prefer to explore:

- **[Path A: v1 (Instant demo identity)](#path-a-v1-instant-demo-identity)** - Recommended if you want zero-configuration and want to inspect business logic right away.
- **[Path B: v2 (Real Google Sign-In & JWT)](#path-b-v2-real-google-sign-in--jwt)** - Recommended if you want to trace production-style token exchange and JWT verification.

#### Path A: v1 (Instant demo identity)

v1 does not need a separate login step, it only uses dummy-auth. There is no token to decode or provider to configure. It immediately lets you test user-specific behavior. You can directly call the endpoint without any credentials, and the dummy-auth middleware will set the user_id to the seeded demo user's UUID.

```text
Client sends a request without any Authorization header
      │
      ▼
dummyAuth - assigns the seeded demo user's UUID to req.user_id
      │
      ▼
processes the request with req.user_id
      │
      ▼
Return data to client
```

Read:

```text
src/routes/products.js
src/middleware/dummyAuth.js
src/controllers/products.controller.js
src/services/product.service.js
```

#### Path B: v2 (Real Google Sign-In & JWT)

v2 separates **logging in** from **calling protected API endpoints**:

```text
1. Login stage:
   Client (Google ID token) ──> POST /api/v2/auth/google ──> Backend issues MyStore JWT

2. Protected request stage:
   Client (Authorization: Bearer <JWT>) ──> GET /api/v2/products/mine
```

The login endpoint is different from normal authenticated requests, client must send Google ID token instead of JWT. Below illustrates the login flow:

```text
Client sends Google ID token
      │
      ▼
POST /api/v2/auth/google
      │
      ▼
verifyGoogleIdToken() - verifies Google ID token with Google and extracts user profile (sub, email, picture_url, etc.)
      │
      ▼
findOrCreateByGoogleProfile() - finds or creates a user in our database based on the Google profile (id or email)
      │
      ▼
signAppToken() - signs the application JWT
      │
      ▼
Return JWT & user info to client
```

After this endpoint succeeds, the client stores the JWT and sends it in Authorization: Bearer header to protected endpoints.

```text
Client sends Authorization: Bearer <JWT> header to protected endpoints
      │
      ▼
jwtAuth - verifies JWT signature and extracts user_id
      │
      ▼
req.user_id is set to extracted user_id
      │
      ▼
processes the request with req.user_id
      │
      ▼
Return data to client
```

Read:

```text
src/routes/auth.js
src/controllers/auth.controller.js
src/services/auth.service.js
src/utils/googleAuth.js
src/utils/jwt.js
src/middleware/jwtAuth.js
src/controllers/products.controller.js
src/services/product.service.js
```

#### The shared contract: why this design matters

Compare the two paths:

```text
v1: request ──> dummyAuth ─────────────┐
                                       ├──> req.user_id ──> controller ──> service ──> model
v2: request ──> jwtAuth (verify JWT) ──┘
```

Notice that `products.controller.js`, `product.service.js`, and `models/Product.js` are **100% identical** across both versions. They do not know or care how authentication happened - they only care about `req.user_id`.

### 5. Study ownership

**Goal:** understand the difference between knowing a resource ID and being allowed to change that resource.

Follow:

```http
PUT /api/{version}/products/:id
DELETE /api/{version}/products/:id
```

_(Works in both `/api/v1/...` and `/api/v2/...`)_

The service checks:

1. does the product exist?
2. does its `creator_id` match `req.user_id`?
3. if yes, perform the mutation.

This is an important pattern for user-owned resources: the service never trusts an owner ID sent from the client body - it always verifies against `req.user_id`.

### 6. Study PostgreSQL transactions

**Goal:** understand why related database changes are grouped together.

Read these model methods:

```text
Product.create
Product.updateById
Product.deleteById
Cart.upsertItem
Order.create
```

Each can change multiple records and therefore uses a transaction. Ask yourself: **what would happen if step 2 succeeded but step 3 failed?** The transaction is there so the database can return to the state before the operation started.

### 7. Understand the cart-to-order workflow

**Goal:** follow one business operation that touches several tables.

Trace:

```text
GET /cart
     │
     ▼
create/find active cart
     │
     ▼
PATCH /cart/items
     │
     ▼
snapshot current product price
     │
     ▼
POST /orders
     │
     ├── copy cart items to order line items
     ├── copy purchase prices
     └── mark cart completed
```

This is the most useful workflow for understanding why the project has separate product, cart, and order price records.

## Code-reading questions

When reviewing a file, ask:

1. **What responsibility does this file own?**
2. **What does it know that other layers should not need to know?**
3. **What does it receive from the layer above it?**
4. **What does it return?**
5. **What can fail?**
6. **Is the failure represented with the correct HTTP/application error?**
7. **If the operation changes multiple database records, is it transactional?**
8. **Is any client-controlled identity trusted without verification?**

These questions are more valuable than memorizing the folder names.
