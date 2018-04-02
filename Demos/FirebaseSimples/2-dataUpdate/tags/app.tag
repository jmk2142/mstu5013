<app>
	<input type="text" ref="authorInput" placeholder="Enter author">
	<input type="text" ref="msgInput" placeholder="Enter message">
	<button type="button" onclick={ saveMsg }>Save Message</button>

	<script>
		var tag = this;

		var messagesRef = rootRef.child('messages');

		// Here username is static, but can come from a UI, or Google auth user object etc. Note that username is different than author. E.g. two people can have the same first name, but not the same username/uid.
		var userID = "alpha123";

		// This function will update database at two locations.
		// under `messages/uniqueMsgID` and `messagesByUser/username/uniqueMsgID`
		saveMsg(e) {
			var key = messagesRef.push().key;

			var msg = {
				id: key,
				author: this.refs.authorInput.value,
				message: this.refs.msgInput.value,
				uid: userID
			};

			var refLocations = {};

					// Ref location A to set data
					refLocations['messages/' + key] = msg;

					// Ref location B to set data
					refLocations['messagesByUser/' + userID + '/' + key] = msg;

			rootRef.update(refLocations);
		}

		/***
		`var refLocations` object above, ends up looking like this:

		{
			"messages/someKey": {                 // REF location A to set data
				id: "someKey",
				author: "someAuthor",
				message: "someMessage",
				uid: "alpha123"
			},
			"messagesByUser/alpha123/someKey": {  // REF location B to set data
				id: "someKey",
				author: "someAuthor",
				message: "someMessage",
				uid: "alpha123"
			}
		}

		So we are setting `msg` to two locations:
			- "messages/someKey"
			- "messagesByUser/alpha123/someKey"

		The power of update() is that you can set multiple locations at once.

		***/


	</script>

	<style>
		:scope {
			display: block;
		}
	</style>
</app>
