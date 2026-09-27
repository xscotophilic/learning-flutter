# MyStore Backend

MyStore is a small REST API built as an **educational project only**.

The code is intentionally structured so you can see how routing, authentication, controllers, services, models, PostgreSQL, migrations, Docker, and integration testing fit together without a large framework or unnecessary abstraction.

> [!IMPORTANT]
> **Educational project only.** Some choices are intentionally simplified for learning, including the fixed demo identity used by v1 and the illustrative payment-related data.

## Where should I start?

Choose the path that matches what you want to do:

- **I just want to run it** -> [Local Setup](./docs/SETUP.md)
- **I want to understand how it works** -> [Learning Guide](./docs/LEARNING_GUIDE.md)
- **I want to understand the architecture** -> [Architecture & Design](./docs/ARCHITECTURE.md)
- **I am looking for an endpoint** -> [API Reference](./openapi.yaml)

If you are learning backend development, start with the [Learning Guide](./docs/LEARNING_GUIDE.md). It explains the request flow in plain language and then points you to the exact files to read.

## Quick start

Check [Local Setup](./docs/SETUP.md) for the setup instructions.

## Documentation

| Document                                        | Use it for                                                                                           |
| ----------------------------------------------- | ---------------------------------------------------------------------------------------------------- |
| [Local Setup](./docs/SETUP.md)                  | configuration, migrations, running the project, and troubleshooting                                  |
| [Learning Guide](./docs/LEARNING_GUIDE.md)      | A step-by-step path for studying and extending the code                                              |
| [Architecture & Design](./docs/ARCHITECTURE.md) | Architecture, request lifecycle, authentication, database design, transactions, and design decisions |
| [API Reference](./openapi.yaml)                 | Endpoints, request/response formats, authentication, errors, and examples                            |

## Project scope

The repository is intentionally small enough to study while still demonstrating concepts commonly found in larger backend applications. It is **not intended to be used as a real commerce backend** without substantial additional work.

See [Architecture & Design](./docs/ARCHITECTURE.md#11-intentional-limitations) for the boundaries and deliberate simplifications in the project.
