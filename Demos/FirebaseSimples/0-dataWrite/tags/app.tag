<app>
	<input type="text" ref="msgInput">
	<button type="button" onclick={ saveMsg }>Save Message</button>

	<script>
		var tag = this;

		var messagesRef = rootRef.child('/messages');

		// This example will only do so in one location.
		saveMsg(e) {
			var key = messagesRef.push().key;

			// Our data object that we will write to the database.
			// We could design this model to have other properties, like author.
			var msg = {
				id: key,
				message: this.refs.msgInput.value
			};

			// Sets user message at `/messages/uniqueKey`
			messagesRef.child(key).set(msg);
		}

	</script>

	<style>
		:scope {
			display: block;
		}
	</style>
</app>
