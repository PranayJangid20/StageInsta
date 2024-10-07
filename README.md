# Instagram Story Feature in Flutter

This project implements a story feature similar to Instagram's stories in a Flutter application. It allows users to view and interact with stories, incorporating various functionalities such as navigation, caching, and state management using the Cubit.

## Features

- **Story Viewing**: Users can view stories from different users in a carousel format.
- **Timer-based Navigation**: Automatically navigates to the next story after a specified duration.
- **Caching**: Stories are cached for offline viewing using `shared_preferences`.
- **Dynamic Updates**: Updates story viewing status in real-time.
- **Provider & Cubit**: Utilizes Provider and Cubit for state management and business logic separation.

## Architecture

The application follows a clean architecture pattern, organizing code into layers for better maintainability:

- **Presentation Layer**: Contains UI components and business logic using the BLoC pattern to manage state.
- **Domain Layer**: Holds core business logic and service interfaces.
- **Data Layer**: Manages data sources, including local storage and network interactions.

### Design Choices

- **Cubit**: Used to separate the UI from business logic, making the codebase easier to maintain and test.
- **Provider**: Implemented state management for story controller, ensuring components can react to changes efficiently.
- **Caching**: Utilized `shared_preferences` for local storage of stories to improve performance and user experience, allowing offline access to previously viewed stories.

## SOLID Principles Utilization

This project adheres to the SOLID principles to promote clean code and maintainability:

- **Single Responsibility Principle (SRP)**: Each class and method has one responsibility. For example, the `CacheService` is solely responsible for managing caching operations, while the `StoryController` handles story logic and state management.

- **Open-Closed Principle (OCP)**: The code is designed to allow for extension without modification. New story data sources can be added (like `LocalStorage` or `NetworkStorage`) without altering existing code.

- **Liskov Substitution Principle (LSP)**: Subtypes can replace their base types without affecting the correctness of the program. For instance, various implementations of the `StoryDataSource` can be used interchangeably, adhering to the interface contract.

- **Interface Segregation Principle (ISP)**: Interfaces are kept small and specific. For instance, `StoryDataSource` focuses on methods related to story management, allowing clients to depend only on the methods they need.

- **Dependency Inversion Principle (DIP)**: High-level modules (like the presentation layer) do not depend on low-level modules (like data sources). Instead, both depend on abstractions (interfaces), which are injected using a dependency injection framework.

## Integration Tests

Integration tests are included to ensure the functionality of the story feature. The tests cover various aspects of the story flow:

1. **Story Forward Test**: Tests the ability to view a story and verifies that the expected widget appears after Timer-based Navigation ends, If timer not perform as expected it fails.

2. **Story Pause Test**: Tests the ability to pause a story while it is being viewed and ensures the correct image is displayed after resuming.

3. **Drag to Close Test**: Verifies that users can drag down to close the story viewer, checking that the correct widget appears afterward.

These tests are implemented using the `integration_test` package, ensuring that the application's core functionalities work as intended across different scenarios.

