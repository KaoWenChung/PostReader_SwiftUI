# TechnicalTest.iOS
* Without any third party library.

## Requirements
- iOS 14+.
- Run in Xcode 13 or newer.
- Written in Swift 5 or newer.

## Features
### UI Implementation
- Implement the tab bar to show two options
  - post list
  - favorite post list
- Implement a list to show posts
  - select one of the posts to see post detail
  - tap the comment button to see the comments on this post
  - tap the save button to save to favorite posts
- Implement favorite posts to show a list of favorite posts
### API Data Fetching
- Get posts by get API https://jsonplaceholder.typicode.com/posts
- Get comments of post by get API https://jsonplaceholder.typicode.com/posts/{postID}/comments/
### Offline Persistent storage
- Use Core Data to implement persistent offline storage with the following features:
  - Read/ Write/ Delete the favorite posts
### Localized Content
- Used Extension Protocol with enumeration to define and use localized strings.
### Test Implementation
- Unit testing
  - Implement dependency injection and mock dependencies to improve the testability of code.
- UI testing

## Technologies:
- Swift
- SwiftUI
- Combine
- MVVM-Coordinator
- OOP
- POP
- Clean Architecture
- Concurrency(await async)
- Core Data(offline storage)
- Unit testing
- UI testing
- Localized string

## To-Do list of features and time I need:
- [x] Improve the coverage of unit testing - 1 hour
- [x] Implement Error Handling
- [x] Implement UI tests - 1 hour
- [ ] present the number of offline posts the bar button - 1 hour
- [ ] Implement the offline comment of post - 1 hour
