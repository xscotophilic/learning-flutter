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

#### Getting a `GOOGLE_CLIENT_ID` for a Flutter app + webapp

If you have multiple clients (e.g. a Flutter app and a webapp), you'll create multiple OAuth client IDs in Google Cloud Console, but the backend generally only needs **one** of them:

1. In [Google Cloud Console](https://console.cloud.google.com/), create/select a project, then configure the **OAuth consent screen** under _APIs & Services_.
2. Under _APIs & Services → Credentials → Create Credentials → OAuth client ID_, create one client ID per platform:
   - **Web application** - used by your webapp directly.
   - **Android** - requires your app's package name + SHA-1 signing fingerprint. When done this will give you a json file. Save it we will use it later.
   - **iOS** - requires your app's bundle ID. When done this will give you a plist file. Save it we will use it later.
3. In the Flutter app, configure `google_sign_in` with the **Web** client ID as `serverClientId`:

   ```dart
   final googleSignIn = GoogleSignIn(
     serverClientId: 'YOUR_WEB_CLIENT_ID.apps.googleusercontent.com',
   );
   ```

```

This makes Google issue an ID token audienced to your Web client ID even when the user signs in from the native app, so both clients produce tokens your backend can verify against the same ID.

4. Set `GOOGLE_CLIENT_ID` in your backend's `.env` to that **Web application** client ID.

If you end up with tokens audienced to more than one client ID (e.g. a native flow that doesn't use `serverClientId`), `GOOGLE_CLIENT_ID` can be set to a comma-separated list and all of them will be accepted as valid audiences.
```
