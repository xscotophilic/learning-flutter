# Sending HTTP Requests

## Project Structure

```text
├── README.md
├── docs/
│   ├── 01.http_client_and_api_client.md
│   ├── 02.error_handling_and_exceptions.md
│   ├── 03.api_repositories_integration.md
│   └── 04.my_store_walkthrough.md
└── my_store/
    └── Complete showcase application
```

## What We Will Learn

- Build a centralized HTTP client wrapper using `http.Client`
- Configure base URL management, default headers (`Content-Type`, `Accept`), and request timeouts
- Map HTTP status codes and decode JSON responses uniformly
- Define domain-specific network exceptions using a sealed `ApiException` hierarchy
- Inject `http.Client` and `ApiClient` into Riverpod provider containers
- Switch repositories from mock implementations to REST API-backed versions (`ApiProductRepository`, `ApiCartRepository`, `ApiFavoritesRepository`, `ApiOrdersRepository`)
- Handle offline connectivity (`SocketException`) and timeouts cleanly in the Flutter UI

## Why Do We Need HTTP Requests?

Transition our showcase app from in-memory mocks to sending real HTTP requests to a REST API backend to persist data.

## Documentation

### Recommended Reading Order

Read these guides in order:

1. [docs/01.http_client_and_api_client.md](docs/01.http_client_and_api_client.md)
2. [docs/02.error_handling_and_exceptions.md](docs/02.error_handling_and_exceptions.md)
3. [docs/03.api_repositories_integration.md](docs/03.api_repositories_integration.md)
4. [docs/04.my_store_walkthrough.md](docs/04.my_store_walkthrough.md)

### Section 1: HTTP Client & ApiClient Wrapper

Configure the `http` package, build a custom `ApiClient` wrapper for REST requests, handle timeouts, and manage its lifecycle. See [docs/01.http_client_and_api_client.md](docs/01.http_client_and_api_client.md).

### Section 2: Error Handling & Exceptions

Convert connection failures and HTTP status codes into a sealed `ApiException` hierarchy. See [docs/02.error_handling_and_exceptions.md](docs/02.error_handling_and_exceptions.md).

### Section 3: API Repositories & Riverpod Integration

Implement concrete API repositories, parse JSON response payloads, and inject them into Riverpod providers. See [docs/03.api_repositories_integration.md](docs/03.api_repositories_integration.md).

### Section 4: Showcase App Walkthrough

Check the complete showcase application to see how we replaced in-memory mocks with the REST API integration. See [docs/04.my_store_walkthrough.md](docs/04.my_store_walkthrough.md).
