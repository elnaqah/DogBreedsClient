
# DogBreedsClient

**DogBreedsClient** is an iOS application built with Swift, designed to display a list of dog breeds and their details by consuming an API. The app uses modular architecture with well-defined layers, including network, UI, and dependency injection, for clear separation of concerns and ease of maintenance.

## Project Structure

```
.
├── DogBreeds
│   ├── DependencyInjection         # Dependency injection setup
│   ├── Navigation                  # Navigation between app screens
│   ├── Network                     # Network layer for API calls
│   ├── Repositories                # Data repositories for fetching and caching data
│   ├── UI                          # UI components and views
│   ├── DogBreedsApp.swift          # Main app entry point
│   └── Info.plist                  # App configuration
├── DogBreeds.xcodeproj             # Xcode project file
├── DogBreedsTests                  # Unit tests
└── README.md                       # Project documentation
```

### Key Components

- **Network Layer**: Implements network calls using `URLSession` to fetch data from the DogBreeds API. Handles errors.
  - `DogBreedNetworkClient`: Manages API requests.
  - `BreedsEndpoint`: Defines endpoints for the dog breeds API.

- **Repositories**: Abstraction for data handling. Contains the logic to fetch and store data locally or remotely.
  - `BreedsRepository`: Retrieves the list of breeds, caching it if necessary.
  - `LocalRepository`: Stores data locally for offline use.

- **Dependency Injection**: 
Using pure dependency injection with composition root.
The `CompositionRoot` and `Composer` handle injecting dependencies across the app to maintain a decoupled architecture.
The composers are segregated in a design pattern that can be simply generated to provide automatic code injection.
@autoclosure are used to avoid cyclic depenedency in some case, an enhancment to this dependency injection aprouch is to construct the dependency tree and detect cyclic dependency on compilation time.
This approuch use the typed compiler to resolve dependency on compilation time.

- **UI**: 
  - `ListView` and `DetailsView`: Present the list of breeds and the details of selected breeds.
  - `ListViewModel` and `DetailsViewModel`: Handle the presentation logic for each view.

- **Navigation**: Manages the routing between different screens using the `Router` and navigation delegates.
The pattern used in this navigation approuch are meant to bubble the navigation outside of the UI components, so the UI Components does not have knowledge of eachother.
This approuch allow multiple teams to work on different UI Screens without affecting each other. 
It also open the capability to remote dynamic routing.

### Tests

The project contains unit tests in the `DogBreedsTests` folder.
The network layer is tested using mocks to ensure reliable and isolated testing.
This is just an example that should be applied on the rest of the project.

## Requirements

- iOS 18.0+
- Xcode 16.0+
- Swift 5.0+
Complete Strict concurency are enabled for this project.

## Installation

1. Clone the repository:
   ```bash
   git clone https://github.com/elnaqah/DogBreedsClient.git
   ```
2. Open the project in Xcode:
   ```bash
   open DogBreeds.xcodeproj
   ```
3. Build and run the app on a simulator or physical device.

## Future work

- Increase unit test coverage.
- Add code generation for the dependency injection, and navigation.
- Use xcode gen to avoid conflic in the project files.
- Separate the shared UI components from the views.

## License

This project is licensed under the MIT License.