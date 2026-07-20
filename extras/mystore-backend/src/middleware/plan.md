# Problem Statement

This API is used for an educational course with two independent modules.

- **v1** teaches consuming REST APIs without introducing authentication (fake header: `x-user-id`).
- **v2** builds on the same API and introduces Google Sign-In and JWT-based authentication.

The challenge is to add authentication in v2 **without breaking v1**. Students following the first module should continue to use the API exactly as before, while students following the second module should use proper authentication.

# Proposed Architecture

Maintain two API versions:

```text
/api/v1
/api/v2
```

Both versions should share as much implementation as possible (controllers, services, models, database access, etc.). The primary differences should be the route registration and authentication middleware.

## v1 Authentication

v1 should **not** perform real authentication.

Instead, it should use a placeholder authentication middleware that behaves as though authentication has already succeeded.

Current controllers expect the authenticated user's identifier to be available as:

```js
req.user_id;
```

The v1 middleware should simply populate this value with a fixed demo user ID and continue.

Example:

```js
export default function auth(req, res, next) {
  req.user_id = "demo-user";
  next();
}
```

This keeps the controller logic unchanged while allowing students to focus purely on making HTTP requests.

## v2 Authentication

v2 introduces real authentication.

Add an endpoint:

```text
POST /api/v2/auth/google
```

Authentication flow:

1. Client signs in with Google.
2. Client sends the Google ID token to `/auth/google`.
3. Backend verifies the Google ID token.
4. Backend creates or retrieves the local user.
5. Backend issues its own application JWT (Bearer token).
6. Client stores this Bearer token and sends it with all subsequent authenticated requests.

Protected routes should use a real authentication middleware that:

- validates the application's JWT,
- extracts the authenticated user,
- sets:

```js
req.user_id = <authenticated user id>;
```

- returns `401 Unauthorized` if the token is missing or invalid.

The middleware can retain the same interface as today:

```js
export default function auth(req, res, next) {
  // Verify JWT
  // Extract user id
  req.user_id = user.id;
  next();
}
```

# Authentication Design

The Google ID token should only be used during login.

```text
Google ID Token
        ↓
POST /auth/google
        ↓
Verify with Google
        ↓
Find/Create local user
        ↓
Issue application JWT
        ↓
Authorization: Bearer <application JWT>
```

After login, **all protected endpoints should accept only the application's own Bearer token**, never the Google ID token directly.

# Goal

- Keep v1 stable forever.
- Introduce authentication cleanly in v2.
- Reuse controllers, services, and business logic.
- Keep the only meaningful differences between versions to:
  - route registration,
  - authentication middleware,
  - the new `/auth/google` endpoint.

This minimizes duplication while keeping the course modules completely independent.
