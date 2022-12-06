# TechnicalTest.iOS
* Without any third party library.

## Requirements
- iOS 14+.
- Run in Xcode 13 or newer.
- Written in Swift 5 or newer.

## Features
### UI Implementation
- Tab bar 
- post scene
  - posts list view
  - post detail
  - comment of post
- favorite scene
  - favorite posts
### API Data Fetching
- Get posts by get API https://jsonplaceholder.typicode.com/posts
- Get comment of post by get API https://jsonplaceholder.typicode.com/posts/{postID}/comments/
### Offline Persistent storage
- Save and read favorite post
### Functions Implementation
- Save posts
### Test Implementation
- Unit testing
- UI testing

## Technologies:
- Swift
- SwiftUI
- Combine
- MVVM
- Clean Architecture
- Concurrency
- Coordinator
- Core Data
- Offline
- Unit testing
- UI testing
- Localized string

## To-Do list of features and time I need:
- [ ] Improve the coverage of unit testing - 1 hour
- [x] Fix TODO items
- [x] Implement Error Handling
- [ ] Implement UI tests - 1 hour
- [ ] present the number of offline posts the bar button - 1 hour
- [ ] Implement the offline comment of post - 1 hour
