# Bright iOS Technical Test

## The Starter Project

You're given an existing codebase that uses the JSON placeholder API to display
a list of posts. The list includes the title of each post and an excerpt from
each post's body. Tapping a post opens a post details screen that displays the
title and complete body of the post.

The architecture of the starting application is deliberately poor. We're
interested in seeing how you could improve the architecture to make it more testable.

## The API

You will need to use the following endpoints from the [JSON
placeholder](https://jsonplaceholder.typicode.com) API to complete the take home
test:

    GET https://jsonplaceholder.typicode.com/posts/

    GET https://jsonplaceholder.typicode.com/posts/{POST_ID}/

    GET https://jsonplaceholder.typicode.com/posts/{POST_ID}/comments/

All endpoints return a JSON response.

## The Tasks

1. Add a button to the post details screen that navigates to a new screen
   showing a list of all comments on the post. Each item in the list should
   show the author and body of the comment.
2. Add a button to the post details screen that saves a post to be read
   offline. The state of the button should reflect whether the post is saved to
   read offline.

   There should be a separate post list screen that displays only posts that
   are saved for offline reading. It should look and behave identically to the
   original post list screen.

   The original post list and the offline post list screens should be embedded
   in a tabbed view. The tab item for the offline post list screen should be
   badged with the number of offline posts that have been saved. The badge
   value should update in the background (i.e., without having to open the
   offline post list screen).

   Only details about the post have to be available to read offline. Post
   comments do not have to be available offline (but it'd be nice if they are).

## Provided Resources

Included in the starter repository:

- Some icons extracted from SFSymbols that you can use for the tasks.
- API response bodies so you can complete the test if you're having connection
  issues.

## Requirements

- The project should build for iOS 14+.
- Should be written in Swift 5 or newer.
- The project should build and run without warnings in Xcode 13 or newer.
- The app should scale from the iPhone SE to the iPhone 12 Pro Max.
- Error handling should be considered.
- You can use third party packages but be prepared to justify your
  choices.
- Submission must include unit tests.

## Submission

Please submit a compressed git repository containing your code 
or provide us a link to your repository. 
Please commit regularly as you carry out the task and keep the commit history in tact.
