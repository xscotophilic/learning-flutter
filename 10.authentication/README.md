#### Getting a `GOOGLE_CLIENT_ID` for a Flutter app + webapp

If you have multiple clients (e.g. a Flutter app and a webapp), you'll create multiple OAuth client IDs in Google Cloud Console, but the backend generally only needs **one** of them:

1. In [Google Cloud Console](https://console.cloud.google.com/), create/select a project, then configure the **OAuth consent screen** under _APIs & Services_.
2. Under _APIs & Services → Credentials → Create Credentials → OAuth client ID_, create one client ID per platform:
   - **Web application** - used by your webapp directly.
   - **Android** - requires your app's package name + SHA-1 signing fingerprint.
   - **iOS** - requires your app's bundle ID. When done this will give you a plist file. Save it we will use it later.
3. In the Flutter app, configure `google_sign_in` with the **Web** client ID as `serverClientId`:

   ```dart
   final googleSignIn = GoogleSignIn(
     serverClientId: 'YOUR_WEB_CLIENT_ID.apps.googleusercontent.com',
   );
   ```

   This makes Google issue an ID token audienced to your Web client ID even when the user signs in from the native app, so both clients produce tokens your backend can verify against the same ID.

4. Set `GOOGLE_CLIENT_ID` in your backend's `.env` to that **Web application** client ID.

If you end up with tokens audienced to more than one client ID (e.g. a native flow that doesn't use `serverClientId`), `GOOGLE_CLIENT_ID` can be set to a comma-separated list and all of them will be accepted as valid audiences.
