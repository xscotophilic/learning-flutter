# My Store

## Configuration & Environment Setup

Before running the application, make sure to configure the API base URL and Google OAuth Client IDs.

### 1. API Base URL (`https://your-app.domain/api/v2`)

By default this points to a placeholder value; swap it out for the API you want the app to use.

**Where:** [`lib/core/dependency_injection/network_providers.dart`](./lib/core/dependency_injection/network_providers.dart). Replace `'https://your-app.domain/api/v2'` with your actual endpoint.

**Options:**

- **Demo backend (for following along with this tutorial)** - a sample server is included at [`extras/mystore-backend`](../../extras/mystore-backend/).
  - Run it locally and set `baseUrl` accordingly: `http://[YOUR_LOCAL_IP]:3000/api/v2`
  - Deploy it yourself - you can also deploy the demo backend (or your own) to a server and just paste that API URL into `baseUrl`.
- **Your own backend** - point `baseUrl` directly at it. But with that you'll have to change the flutter code to match your backend.

### 2. Google OAuth Configuration

To follow along with the tutorial, you'll need to create a Google OAuth Client IDs. You can check this [Guide](../docs/01.google_sign_in_and_oauth_setup.md) to learn how to create a Google OAuth Client ID.

#### Web Client ID (`YOUR_WEB_CLIENT_ID`)

Required for Google Sign-In backend verification / OAuth configuration across platforms.

- **Location**: [`lib/features/auth/data/repositories/composite_auth_repository.dart`](./lib/features/auth/data/repositories/composite_auth_repository.dart)
- **What to change**: Replace `'YOUR_WEB_CLIENT_ID.apps.googleusercontent.com'` with your Google Cloud Console OAuth Web Client ID.

More detailed explanation is in the [Guide](../docs/01.google_sign_in_and_oauth_setup.md).

#### iOS Client ID (`YOUR_IOS_CLIENT_ID`)

Required for Google Sign-In on iOS.

- **Location**: [`ios/Runner/Info.plist`](./ios/Runner/Info.plist)
- **What to change**:
  1. Replace `YOUR_IOS_CLIENT_ID.apps.googleusercontent.com` under `GIDClientID` with your iOS Client ID.
  2. Replace `com.googleusercontent.apps.YOUR_IOS_CLIENT_ID` under `CFBundleURLSchemes` with your reversed iOS Client ID.

More detailed explanation is in the [Guide](../docs/01.google_sign_in_and_oauth_setup.md).

#### Android Client ID (`YOUR_ANDROID_CLIENT_ID`)

For Android, you don't expilicitly provide the Client ID in the code. Instead, you provide the SHA-1 fingerprint of your app's signing certificate and the package name to the Google Cloud Console. More detailed explanation is in the [Guide](../docs/01.google_sign_in_and_oauth_setup.md).

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
