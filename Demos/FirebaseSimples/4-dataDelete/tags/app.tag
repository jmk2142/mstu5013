<app>
	<h1>Hello { userID }</h1>

	<!-- UI for username / userID setting -->
	<div>
		<input type="text" ref="userInput" placeholder="Enter username/userID">
		<button type="button" onclick={ setUser }>Set Username/UserID</button>
	</div>

	<message each={ msg in messages }></message>

	<div>
		<input type="text" ref="authorInput" placeholder="Enter author">
		<input type="text" ref="msgInput" placeholder="Enter message">
		<button type="button" onclick={ saveMsg }>Save Message</button>
	</div>

	<script>
		var tag = this;

		var messagesRef = rootRef.child('messages');

		this.userID = "anonymous";
		this.messages = [];

		// READs data as soon as this tag is initialized.
		messagesRef.on('value', function(snap){
			var dataAsObj = snap.val();

			if (dataAsObj) {
				tag.messages = Object.values(dataAsObj);
			} else {
				tag.message = [];
			}

			tag.update();
		});

		// WRITEs data at two locations in database.
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

		// Naive way to set the username/userID. Eventually we'll get this information from Google Authentication / Login
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
