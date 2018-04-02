<app>
	<h1>Hello { userID }</h1>

	<!-- UI for username / userID setting -->
	<input type="text" ref="userInput" placeholder="Enter username/userID">
	<button type="button" onclick={ setUser }>Set Username/UserID</button>

	<message each={ msg in messages }></message>

	<input type="text" ref="authorInput" placeholder="Enter author">
	<input type="text" ref="msgInput" placeholder="Enter message">
	<button type="button" onclick={ saveMsg }>Save Message</button>

	<script>
		var tag = this;

		var messagesRef = rootRef.child('messages');
		this.userID = "anonymous"; // Starts anonymous, set by user interface.

		this.messages = [];

		// Listen for data changes (READ)
		// See 0-dataRead
		messagesRef.on('value', function(snap){
			var dataAsObj = snap.val();
			tag.messages = Object.values(dataAsObj);
			tag.update();
		});

		// UPDATE data by setting multiple locations (WRITE)
		// See 2-dataUpdate
		saveMsg(e) {
			var key = messagesRef.push().key;

			var msg = {
				id: key,
				author: this.refs.authorInput.value,
				message: this.refs.msgInput.value,
				uid: this.userID
			};

			var refLocations = {};
					refLocations['messages/' + key] = msg;
					refLocations['messagesByUser/' + this.userID + '/' + key] = msg;

			rootRef.update(refLocations);
		}

		// This sets the username/userID which might be different than the author name. E.g. john123 is "John" and jumpJack007 is also "John"
		setUser(e) {
			this.userID = this.refs.userInput.value;
		}

	</script>

	<style>
		:scope {
			display: block;
		}
	</style>
</app>
