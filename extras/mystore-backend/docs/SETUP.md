# Local Setup

**What this guide does:** gets the backend running on your machine, applies database migrations, and verifies the API with your first request.

Choose the setup method that best fits your workflow:

- **[Option A: Run with Docker](#option-a-run-with-docker)** (Recommended if you prefer containerized environments without installing Node locally)
- **[Option B: Run with Node & npm](#option-b-run-with-node--npm)** (Standard local development setup)

---

## Option A: Run with Docker

Run the entire application in a container.

### Prerequisites

- [Docker](https://docs.docker.com/get-docker/) installed and running.
- PostgreSQL database accessible from Docker (either running locally on the host, in a Docker network/container, or hosted remotely).
- `curl` (for verifying requests).

### 1. Create the database

Create an empty PostgreSQL database named `mystore` (or your preferred name):

```bash
createdb mystore
```

_(You can also create it via `psql`, pgAdmin, or a containerized PostgreSQL instance.)_

### 2. Configure environment variables

Copy the example environment file:

```bash
cp .env.example .env
```

Set your `DATABASE_URL` in `.env`:

```dotenv
PORT=3000
DATABASE_URL="postgresql://username:password@host.docker.internal:5432/mystore"
```

> [!TIP]
> If PostgreSQL runs directly on your host machine, use `host.docker.internal` instead of `localhost` in `DATABASE_URL` so the container can reach your host.

If you plan to use the v2 Google authentication flow, also set:

```dotenv
JWT_SECRET="use-a-long-random-secret"
GOOGLE_CLIENT_ID="your-web-client-id.apps.googleusercontent.com"
```

_(See [Authentication Setup](#authentication-setup) for details on obtaining these keys.)_

> [!IMPORTANT]
> Never commit your real `.env` file or secrets to source control.

### 3. Build the Docker image

From the repository root:

```bash
docker build -t mystore-backend .
```

If deploying to cloud hosting, check [Building Multi-Platform Docker Images](#optional-building-multi-platform-docker-images) section.

### 4. Run database migrations

Before launching the server, apply the SQL migrations using the container image:

```bash
docker run --rm \
  --env-file .env \
  mystore-backend \
  npm run db:migrate
```

_(For details on how migrations work or how to create new ones, see [Database Migrations](#database-migrations).)_

### 5. Start the container

```bash
docker run --rm \
  -p 3000:3000 \
  --env-file .env \
  mystore-backend
```

The API will be available at:

```text
http://localhost:3000
```

### 6. Make a request

Test that the backend is responding by fetching the featured products:

```bash
# v1 endpoint
curl http://localhost:3000/api/v1/products/featured

# v2 endpoint
curl http://localhost:3000/api/v2/products/featured
```

### (Optional) Building Multi-Platform Docker Images

If deploying to cloud hosting or targeting multiple CPU architectures (e.g. `linux/amd64` and `linux/arm64`), use Docker Buildx:

```bash
docker login
docker buildx create --use
docker buildx build \
  --platform linux/amd64,linux/arm64 \
  -t <your-dockerhub-username>/mystore-backend:latest \
  --push .
```

---

## Option B: Run with Node & npm

Run the application directly on your local machine using Node.

### Prerequisites

- [Node](https://nodejs.org/) and `npm`.
- [PostgreSQL](https://www.postgresql.org/) installed and running locally.
- `curl` (for verifying requests).

### 1. Create the database

Create an empty PostgreSQL database named `mystore` (or your preferred name):

```bash
createdb mystore
```

_(You can also use pgAdmin, psql, or any PostgreSQL client.)_

### 2. Configure environment variables

Copy the example environment file:

```bash
cp .env.example .env
```

At minimum, configure the database connection:

```dotenv
PORT=3000
DATABASE_URL="postgresql://username:password@localhost:5432/mystore"
```

For the v2 Google authentication flow, also configure:

```dotenv
JWT_SECRET="use-a-long-random-secret"
GOOGLE_CLIENT_ID="your-web-client-id.apps.googleusercontent.com"
```

_(See [Authentication Setup](#authentication-setup) for details on obtaining these keys.)_

> [!IMPORTANT]
> Never commit your real `.env` file or secrets to source control.

### 3. Install dependencies

From the repository root:

```bash
npm install
```

### 4. Run migrations

The application does not automatically modify the database schema on start. Apply the migrations manually:

```bash
npm run db:migrate
```

_(For details on how migrations work or how to create new ones, see [Database Migrations](#database-migrations).)_

### 5. Start the API

For active development (with automatic restart on file changes):

```bash
npm run dev
```

For a standard production-like local start:

```bash
npm start
```

The default base URL is:

```text
http://localhost:3000
```

### 6. Make a request

Test that the backend is responding by querying the catalog:

```bash
# v1 endpoint
curl http://localhost:3000/api/v1/products/featured

# v2 endpoint
curl http://localhost:3000/api/v2/products/featured
```

---

## Common Information & Advanced Topics

### Database Migrations

The migration runner:

1. Creates the migration tracking table (`_migrations`).
2. Applies pending SQL migrations in filename order from `src/db/migrations/`.
3. Records each applied migration.
4. Seeds the demo users and sample products through the included migrations.

Running the migration command again is safe when there are no new migrations.

#### Adding a new migration

Create the next numbered SQL file in `src/db/migrations/`:

```text
004_add_product_category.sql
```

> [!WARNING]
> Do not edit an already-applied migration file to change an existing schema. Always add a new numbered migration file instead.

---

### Authentication Setup

#### Which authentication should I use first?

If you are learning the project, start with **v1**. It uses a fixed demo identity (`user-1`), so you can immediately test protected endpoints (cart, orders) without configuring external accounts. Move to **v2** when you want to explore a production-ready Google Sign-In + JWT flow.

#### v1: Demo identity

The v1 API uses a fixed seeded demo user for protected operations. This keeps the early tutorial simple without requiring a sign-in provider.

#### v2: Google Sign-In + JWT

The v2 authentication flow:

```text
Client
  │
  │ Google Sign-In
  ▼
Google ID token
  │
  │ POST /api/v2/auth/google
  ▼
Backend
  │
  ├── verify Google ID token
  ├── find or create local user
  └── issue application JWT
            │
            ▼
  Authorization: Bearer <JWT>
```

The Google ID token is used solely to verify identity. It is not the application's persistent API session token.

#### Obtain a Google Client ID

1. Create a project in the [Google Cloud Console](https://console.cloud.google.com/).
2. Configure the OAuth Consent Screen (Optional for backend setup):
   - Go to **APIs & Services** > **OAuth consent screen**.
   - Select **External** and complete the required app configuration fields.
3. Create Credentials (OAuth Client IDs):
   - Go to **APIs & Services** > **Credentials** > **Create Credentials** > **OAuth client ID**.
   - Select **Web application**. (Required even for non-web clients; the backend uses this Web Client ID to verify tokens against the token's audience `aud` field).
   - Add the resulting client ID to your `.env` as `GOOGLE_CLIENT_ID`.

#### Client configuration

When integrating Google Sign-In into frontend clients (web, mobile, desktop, etc.), configure the server/client ID to match your backend Web Client ID. Once the user signs in on the client, exchange the resulting Google ID token with `POST /api/v2/auth/google` to receive your application JWT for authenticating subsequent requests.
