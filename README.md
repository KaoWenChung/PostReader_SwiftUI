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
  - select one itme of the post will show post detail
  - tap the comment button will show the comments of this post
  - tap save to save to favorite posts
- Implement favorite posts to show a list of favorite posts
### API Data Fetching
- Get posts by get API https://jsonplaceholder.typicode.com/posts
- Get comment of post by get API https://jsonplaceholder.typicode.com/posts/{postID}/comments/
### Offline Persistent storage
- Use Core Data to implement offline persistent storage with the following features:
  - Save the favorite posts
  - Show the favorite posts
  - Delete the favorite posts
### Localized Contnet
- Used Protocol Oriented Programming with enumeration to define and use localized strings.
### Test Implementation
- Unit testing
  - Implement dependency injection and mock dependencies to improve the testability of code.
- UI testing

## Technologies:
- Swift
- SwiftUI
- Combine
- MVVM
- OOP
- POP
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
- [ ] Fix TODO items
- [x] Implement Error Handling
- [x] Implement UI tests - 1 hour
- [ ] present the number of offline posts the bar button - 1 hour
- [ ] Implement the offline comment of post - 1 hour
