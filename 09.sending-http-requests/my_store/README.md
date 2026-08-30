# My Store

## Configuration & Environment Setup

Before running the application, make sure to configure the API base URL and Google OAuth Client IDs.

### 1. API Base URL (`https://your-app.domain/api/v1`)

By default this points to a placeholder value; swap it out for the API you want the app to use.

**Where:** [`lib/core/dependency_injection/network_providers.dart`](./lib/core/dependency_injection/network_providers.dart). Replace `'https://your-app.domain/api/v1'` with your actual endpoint.

**Options:**

- **Demo backend (for following along with this tutorial)** - a sample server is included at [`extras/mystore-backend`](../../extras/mystore-backend/).
  - Run it locally and set `baseUrl` accordingly: `http://[YOUR_LOCAL_IP]:3000/api/v1`
  - Deploy it yourself - you can also deploy the demo backend (or your own) to a server and just paste that API URL into `baseUrl`.
- **Your own backend** - point `baseUrl` directly at it. But with that you'll have to change the flutter code to match your backend.

## Getting Started

1. **Install dependencies**:

   ```bash
   flutter pub get
   ```

2. **Code generation** (if modifying annotated files):

   ```bash
   dart run build_runner build --delete-conflicting-outputs
   ```

3. **Run the application**:
   ```bash
   flutter run
   ```
