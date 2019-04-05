# Tinker: Firestore II

Github URL: https://github.com/jmk2142/mstu5013/tree/master/Tinkers/Firebase-Tinkers/Firebase-II

In this tinker, users can fake-register/login, create laboroatories (rooms where users can "chat"), and browse labs that have been created via categories.

Part of this tinker is about identifying and recognizing some of the concepts and patterns we've been using so far.

Part of this tinker is about expanding this code and usability, using the demonstrated principles.

---

## Login / Registration `<app>`

Note that this is not a true login/registration - anyone can just claim to be user `abc123` (no password.) But we'll use this as an example of how applications can use login information with other data that users may want to create, read, delete.

- Explain how the app can show a different view based on whether a user is "logged in" or "not", and how it decides which view to show.

- How does the "Remember Me" option work? (How does the computer remember that this user is logged in?)

- We pass the `user` data into the children tags `<kitchen-lab-editor>` and `<kitchen-lab-browse>`. Why is this important?

## Create a Kitchen Lab `<kitchen-lab-editor>`

When I call `createLab()`, I collect a comma separated string and process that into a `keywords` array. There are several steps involved in this processing.

- How does does the String to Array conversion of keywords work?
  - **BONUS**: What is `/[^a-zA-Z0-9]/g` and `/\s/g` gibberish?

When I create a new `lab`, the data has a property called `owner`.

- Where does that information come from?

In the last part of `createLab()` I am executing the actual database operation. I am writing to two distinct locations in the database.

- Where are these two location references?
- Why are we (re)creating lab data in two locations?
- I use something called `batch()` rather than call `set()` directly, twice. What is `batch()`, how does it work, and why bother?


## Browse Kitchen Labs `<kitchen-lab-browse>`

Before browsing, create several kitchen labs from several different users.

- Give your users different dietary restrictions.
- When you carete your kitchen labs, include in some of your rooms the keywords: `vegetarian`, `gluten`, or `lactose`

When browsing, users can switch between browsing _all labs_, _my labs_, as well as labs with specific restrictions as users have indicated when they registered.

- How is the user restriction data being used to generate the lab query options?
- At the top of this tag, I cache the firebase queries. Why do this and how am I using it in the `changeQuery()` method?
- How does the `changeQuery()` method work?

---
# Modifying the Kitchen Lab


## Basic Features

This application doesn't have any way to update information or delete information.

- Can you add functionality to the app so that users can update only the labs that _they have created?_
- Can you add functionality to the app so that users can delete only the labs that _they have created?_
- Can you modify the queries to change the `limit()`, `orderBy()`, and `where()` filters?
  - You might also have to modify how the app saves lab data if you want to get a particular kind of behavior.

:::info
Remember, labs are located in two locations.
:::

## Advanced Features

This application stops short of the user experience of what happens when users **Join a Lab**. Create a small new component (or keep modifying the existing ones, or both) to complete the experience.

Here, I'm not so interested that you accomplish the following - but more interested in how you envision the experience and create what you imagine. But in case you need an idea:

### Ideas

- **What is a Kitchen Lab?** One idea is that by _joining_ a lab, a user can join a live chat room. Modify the `<kitchen-lab-room>` tag and/or add other tags to complete this experience.
  - What should the data architecture look like?
- **Info about Kitchen Labs** It'd be cool if before we _joined_ users could see some information about the lab.
  - How many people have joined?
  - When was the lab last active (3 hours ago)
  - Preview of the conversation, the last message etc.

:::info
Remember, what you add will probably have an implication for how you store your data on Firestore. Think data architecture for *read-optimization*.

E.g. It'd be nice to get the number of people joined, last active, preview etc. without having to make any other special and distinct data queries.
:::

There are many other things you could do to continue to build out from this base code. Think of some idea that would make this more user friendly and hack something together.
