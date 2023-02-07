# AdyenChallenge (iOS app)
An iPhone-App in Swift for displaying nearby venues using [Foursquare-Places-API](https://location.foursquare.com/developer/reference/place-search).
This app is built for [Adyen](https://www.adyen.com) iOS job application/recruitment and is for demonstration purposes only.



#### Dependacy Managers:
Application does not use any dependency manager such as CocoaPods, Carthage, Swift Package Manager.

### 1. Running the project
- To be able to install the build on the iPhone you will be needing Apple Developer provisioning and certifcate. You can create your Apple developer account [here](https://developer.apple.com/).
- To run the project Navigate to the `{YOUR_LOCAL_PATH}/AdyenChallenge-iOS/AdyenChallenge` and open the project using `AdyenChallenge.xcodeproj`. Run on simulator.

### 2 Project setup:
- Xcode-Version: `>= 13`
- Swift-Version: `5`
- Deployment target:` >= iOS 13`

## 3. Technical details

### 3.1 VIPER (View, Interactor, Presenter, Entity and Router)  
[VIPER](https://www.techtarget.com/whatis/definition/VIPER) is used to develop modular code based on clean design architecture. Protocol oriented approach is used enabling testability of each component individually.


### 3.2 Decisions taken
- User Interface: UIKit is used, developed in code (Xibs / Storyboard is not used)
- Assembly is used to mimic dependency registrar and resolver (later any dependecy injector such as Swinject, Typhoon, etc. could be used.)
- [Command pattern](https://en.wikipedia.org/wiki/Command_pattern) is used for actions/triggers
- API models are kept segregated from UI models to ensure scalability 
- System colors are used to enable Dark mode support

### 3.3 Screens
- Permission: allows user to grant location permission, stays on screen until permission is granted
- Venues: renders venues around user's location, shows indication when fetching venues, allows retry if fails to render venues 

| Permission | Venues Error | Venues |
| ------------- |------------- | ----- |
| ![image](https://user-images.githubusercontent.com/26329199/217108199-70c8fefb-9689-4418-880d-5d9357a099ea.png) | ![image](https://user-images.githubusercontent.com/26329199/217108385-1866a93c-6d6b-4fbe-abf7-134197f93d40.png) | ![image](https://user-images.githubusercontent.com/26329199/217108523-7843a349-f3e5-49c1-a019-1307c95cf304.png) |


### 3.4 Code Structure
Code is divided into following Groups:
- Core: contains the AppDelegate, Assembly (dependency registrar & resolver), Config (configuration file containing API_KEY - pushed in this repo for now).
- Service: contains LocationService and NetworkService.
- Router: contains Router (responsible for routing within app).
- Common: contains utilities and extensions.
- Permission: contains Permission screen components.
- Venues: contains Permission screen components.
- Resource: contains assets files 

### 3.5 Unit Tests
- Unit test are written and provide a code coverage of ***92.5%***.
- Unit tests are written for Interactors, Presenters and Services of both screens. 

### 3.6 Snapshot Tests
- Snapshot tests are not provided.

### 3.7 UI Tests
- UI tests are not provided.

## 4. What's missing?
- Give the user a possibility to adjust the radius of interest (Optional)
- Network reachability to check if internet connected prior to making HTTP request
- More unit test coverage
- Snapshot tests for UI components
- UI tests for flows 
- Linter(SwiftLint, etc.) can be added for consistant code style 
- Improved UI

## 5. Authors
- **[Sajjad Haider](https://github.com/sajjadhaiderzaidi)**

## 6. License
This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details
