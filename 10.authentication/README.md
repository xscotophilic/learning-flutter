### To setup android app you will need SHA-1 fingerprint.

If you are just learning and not planning to deploy the app, you can use the debug keystore.

```bash
keytool -list -v \
  -alias androiddebugkey \
  -keystore ~/.android/debug.keystore \
  -storepass android \
  -keypass android
```

if you wanna generate your own keystore run this command (preferred for deployment):

```bash
keytool -genkeypair -v \
  -keystore ~/upload-keystore.jks \
  -keyalg RSA \
  -keysize 2048 \
  -validity 10000 \
  -alias upload
```

This will generate a keystore file in your home directory named `upload-keystore.jks`.

Move this keystore to your project's android/ directory. Now you can get SHA-1 of this keystore by running the following command:

```bash
keytool -list -v -keystore android/upload-keystore.jks
```

Store this SHA-1 fingerprint somewhere, we will need it later.

In the android/ directory of your Flutter project, create a file named: android/key.properties

```
storePassword=YOUR_KEYSTORE_PASSWORD
keyPassword=YOUR_KEY_PASSWORD
keyAlias=YOUR_ALIAS
storeFile=/absolute/path/to/upload-keystore.jks
```

Configure Gradle `android/app/build.gradle.kts`

Example

```
import java.util.Properties

plugins {
    ...
}

val keystoreProperties = Properties()
val keystorePropertiesFile = rootProject.file("key.properties")

if (keystorePropertiesFile.exists()) {
    keystoreProperties.load(keystorePropertiesFile.inputStream())
}

android {
    ...

    signingConfigs {
        if (keystorePropertiesFile.exists()) {
            create("release") {
                keyAlias = keystoreProperties["keyAlias"] as String
                keyPassword = keystoreProperties["keyPassword"] as String
                storeFile = file(keystoreProperties["storeFile"] as String)
                storePassword = keystoreProperties["storePassword"] as String
            }
        }
    }

    buildTypes {
        debug {
            signingConfig = signingConfigs.getByName("debug")
        }

        release {
            signingConfig = if (keystorePropertiesFile.exists()) {
                signingConfigs.getByName("release")
            } else {
                signingConfigs.getByName("debug")
            }
        }
    }
}
```

#### Setting up OAuth client IDs in Google Cloud Console

Even if you only have a Flutter app (Android + iOS) with no separate
website, you still need to create a **Web application** OAuth client ID.
It's what makes tokens from your native apps verifiable by this backend —
Android/iOS-type client IDs exist only to authorize those native apps to
sign in, they cannot be used as `serverClientId` or as this backend's
`GOOGLE_CLIENT_ID`.

1. In [Google Cloud Console](https://console.cloud.google.com/),
   create/select a project, then configure the **OAuth consent screen**
   under _APIs & Services_.
2. Under _APIs & Services → Credentials → Create Credentials → OAuth
   client ID_, create one client ID per platform:
   - **Web application** - required even without a real webapp; this is
     the only client ID type this backend can verify tokens against. You
     can leave "Authorized JavaScript origins" / "redirect URIs" empty if
     you have no browser-based flow yet.
   - **Android** - requires your app's package name + SHA-1 signing
     fingerprint.
   - **iOS** - requires your app's bundle ID.
   - Each client ID is shown on screen once created (Cloud Console also
     lets you download a generic OAuth client JSON/plist for your own
     reference, but this is not the same as Firebase's
     `google-services.json` / `GoogleService-Info.plist` — it won't be
     auto-read by the plugin, so just note down each client ID to use
     manually below, we will need them later).

3. Set `GOOGLE_CLIENT_ID` in this backend's `.env` to the **Web
   application** client ID. If you ever have tokens audienced to more
   than one client ID, `GOOGLE_CLIENT_ID` also supports a comma-separated
   list, and any of them will be accepted as a valid audience.

4. Wire up the Flutter app so every platform's sign-in produces a token audienced to that same Web client ID, which is what lets this backend verify tokens from Android and iOS alike:
   - **Android**: The Android client ID itself isn't passed anywhere in android native code nor in Dart. Google resolves it automatically from your package name and SHA-1 registered.
   - **iOS**: add the **iOS** client ID to `ios/Runner/Info.plist` as `GIDClientID`, and add the required `CFBundleURLTypes` URL scheme (reversed client ID) — this URL scheme entry is required regardless of how `clientId`/`serverClientId` are configured.

```xml
    <!-- ios/Runner/Info.plist -->
    <key>GIDClientID</key>
    <string>YOUR_IOS_CLIENT_ID.apps.googleusercontent.com</string>

    <key>CFBundleURLTypes</key>
    <array>
      <dict>
        <key>CFBundleTypeRole</key>
        <string>Editor</string>
        <key>CFBundleURLSchemes</key>
        <array>
          <!-- REVERSED_CLIENT_ID for the iOS client -->
          <string>com.googleusercontent.apps.YOUR_IOS_CLIENT_ID</string>
        </array>
      </dict>
    </array>
```

- Common: pass the **Web** client ID as `serverClientId` when initializing `GoogleSignIn` in dart

```dart
       final googleSignIn = GoogleSignIn(
         serverClientId: 'YOUR_WEB_CLIENT_ID.apps.googleusercontent.com',
       );
```

Either way, Google issues an ID token audienced to the Web client ID
even when the user signs in from a native app, so every client
produces tokens this backend can verify against the same
`GOOGLE_CLIENT_ID`.
