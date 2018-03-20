# MSTU CHAT! README.md (Exercise)

Slack is cool, but our own chatroom is cooler. (Not as sophisticated obviously, but it's ours.)

In this exercise that we started in class - we will be working on creating our own chatroom, utilizing Riot and Firebase. We'll expand on the basic functionality presented and think about the way data is represented as discrete units / models of representation as well as how we think about the data architecture / structure of our database.

## Add-on Feature Challenges
1. On page startup, it would be nice for people to be able to enter their "author name", and every message looks like:

	> Jin: Hello!

2. Would be nice if messages had timestamps so it read like:

	> Jin: Hello! - at 12:30pm

3. Each message has a _TRASH_ functionality. "TRASH" can do either of the following things:
	- Either deletes the message from the database.
	- Or changes the message to "[DELETED]", as well as obscures the author name.
	- What is the implication of these choices?
4. People could upvote/downvote a message, where if a message had more than a total of 10 votes, over 50% of which were downvotes, the message shows as "[HIDDEN DUE TO DOWNVOTES]"
	- A running total counter (e.g. 10 votes, -5 votes, etc.)
5. Make it so that a user can go to a separate page/component to see all of their message history (just their messages) and edit/delete them.
	- Think about how your database architecture will be reflected if we think of this problem as a read optimization issue. How can we structure the data on the database so that getting a particular users message is a simple fetch from a single reference? Instead of querying through all messages?
6. The ability to create a "new" chatroom separate from the general chatroom. Maybe allow users to create a "topic" that starts a new chatroom.
	- This has implications for how you think about the database architecture.
7. Other considerations overall to make the experience better.
8. (CHALLENGE) Using `js/utilities.js`, if there is an image or site link in the message - make the message provide the image or link in some way. (Doesn't have to be inline with the text message.)
    - To do any inline inclusion of images and links (creating <img> and <a> elements on the fly see http://riotjs.com/guide/#render-unescaped-html)
    - But not necessary to do some of this stuff.

## Your own features:
1. Give the messages extra features that make it fun, and yours.
	- Think of features that have implications not just for the style/presentation, but also for how a message data object is represented, and/or how the data architecture on the database needs to be structured.
2. Give the app (overall) more "user custom" features. For example, allow them to choose a color scheme so that next time they visit, that color scheme is applied. Or for example, the opportunity to block a user and their junk messages (showing only those messages that are not from a blocked user.)
