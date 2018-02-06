# Dating / Matching Simulator

This dataset mirrors that of a pretend dating application. The following references represent different kinds of information as follows:

```
- friends
	- $userID
		- $friendID-A: $userID's friend
		- $friendID-B
		- ...
	- ...

- limited
	- $userID
		- notesWiki: Wiki for friends to leave advice
		- preferences: Notes by userID for friends on match preferences
	- ...

- private
	- $userID
		- $matchRequestID
			- matchStatus
			- recipient
			- ricipientID
			- sender
			- senderID
		- ...
	- ...

- public
	- $profileID
		- displayName
		- uid
		- status
	- ...
```
