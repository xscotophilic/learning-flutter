# Authentication

## Project Structure

```text
├── README.md
├── docs/
│   ├── 01.google_sign_in_and_oauth_setup.md
│   ├── 02.secure_storage_and_session_persistence.md
│   ├── 03.request_interception_and_token_management.md
│   ├── 04.auth_state_notifier_and_usecases.md
│   └── 05.my_store_auth_walkthrough.md
└── my_store/
    └── Complete showcase application with Google Sign-In
```

## What We Will Learn

- Integrate Google Sign-In authentication in Flutter
- Configure Google Cloud OAuth Client credentials for Web, Android, and iOS platforms
- Persist authentication tokens and user profiles using `flutter_secure_storage`
- Build a custom request interceptor pipeline using `ChainedClient` to attach bearer tokens automatically
- Handle session expiration (`401 Unauthorized`) globally using a central Event Bus
- Guard UI navigation and feature actions (such as adding favorites or modifying cart) based on authentication state
- Wipe in-memory and UI state cache (Cart, Favorites) upon logout or token invalidation

---

## Documentation

### Recommended Reading Order

Read these guides in order:

1. [docs/01.google_sign_in_and_oauth_setup.md](docs/01.google_sign_in_and_oauth_setup.md)
2. [docs/02.secure_storage_and_session_persistence.md](docs/02.secure_storage_and_session_persistence.md)
3. [docs/03.request_interception_and_token_management.md](docs/03.request_interception_and_token_management.md)
4. [docs/04.auth_state_notifier_and_usecases.md](docs/04.auth_state_notifier_and_usecases.md)
5. [docs/05.my_store_auth_walkthrough.md](docs/05.my_store_auth_walkthrough.md)

### Section 1: Google Sign-In & OAuth Setup

Configure developer credentials in the Google Cloud Console, retrieve SHA-1 fingerprints for Android, register reversed schemes in iOS, and wire up `google_sign_in` in Dart. See [docs/01.google_sign_in_and_oauth_setup.md](docs/01.google_sign_in_and_oauth_setup.md).

### Section 2: Secure Storage & Session Persistence

Implement secure key-value storage using the `flutter_secure_storage` library and serialize the user session to keep the user signed in across app launches. See [docs/02.secure_storage_and_session_persistence.md](docs/02.secure_storage_and_session_persistence.md).

### Section 3: Request Interception & Token Management

Build interceptors to attach Authorization headers to outgoing network requests and handle expired tokens globally. See [docs/03.request_interception_and_token_management.md](docs/03.request_interception_and_token_management.md).

### Section 4: Auth State Notifier & Clean Architecture Usecases

Review the domain entities, usecases, repositories, and Riverpod providers used to manage and expose auth state. See [docs/04.auth_state_notifier_and_usecases.md](docs/04.auth_state_notifier_and_usecases.md).

### Section 5: Showcase App Walkthrough

Observe how authentication guards navigation and actions in the UI, coordinates state clearing reactively, and behaves on startup. See [docs/05.my_store_auth_walkthrough.md](docs/05.my_store_auth_walkthrough.md).
