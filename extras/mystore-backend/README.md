# MyStore Backend

A REST API backend for the MyStore application.

For detailed API documentation, endpoint descriptions, and payloads, see the [API Specification](./API.md).

## Getting Started

Follow these steps to set up and run the backend locally.

### Prerequisites

- [Node.js](https://nodejs.org/) (v22 or later recommended)
- [PostgreSQL](https://www.postgresql.org/) database (running locally or via Docker)

---

### Setup and Installation

1. **Install dependencies:**

   ```bash
   npm install
   ```

2. **Configure Environment Variables:**
   Copy the example environment file to `.env`:

   ```bash
   cp .env.example .env
   ```

   Open the `.env` file and configure your local settings:
   - `PORT`: Server port (defaults to `3000`).
   - `DATABASE_URL`: PostgreSQL connection URI.
   - `JWT_SECRET`: Secret key for JWT generation (required for `/api/v2/*` JWT tokens).
   - `GOOGLE_CLIENT_ID`: Google OAuth client ID (required for `/api/v2/*` Google Sign-In).

#### Getting a `GOOGLE_CLIENT_ID` for a Flutter app + webapp

If you have multiple clients (e.g. a Flutter app and a webapp), you'll create multiple OAuth client IDs in Google Cloud Console, but the backend generally only needs **one** of them:

1. In [Google Cloud Console](https://console.cloud.google.com/), create/select a project, then configure the **OAuth consent screen** under _APIs & Services_.
2. Under _APIs & Services → Credentials → Create Credentials → OAuth client ID_, create one client ID per platform:
   - **Web application** - used by your webapp directly.
   - **Android** - requires your app's package name + SHA-1 signing fingerprint.
   - **iOS** - requires your app's bundle ID.
3. In the Flutter app, configure `google_sign_in` with the **Web** client ID as `serverClientId`:

   ```dart
   final googleSignIn = GoogleSignIn(
     serverClientId: 'YOUR_WEB_CLIENT_ID.apps.googleusercontent.com',
   );
   ```

   This makes Google issue an ID token audienced to your Web client ID even when the user signs in from the native app, so both clients produce tokens your backend can verify against the same ID.

4. Set `GOOGLE_CLIENT_ID` in your backend's `.env` to that **Web application** client ID.

If you end up with tokens audienced to more than one client ID (e.g. a native flow that doesn't use `serverClientId`), `GOOGLE_CLIENT_ID` can be set to a comma-separated list and all of them will be accepted as valid audiences.

### Running the Server

- **Development Mode** (with hot-reloading on file changes):

  ```bash
  npm run dev
  ```

- **Production Mode**:
  ```bash
  npm start
  ```
