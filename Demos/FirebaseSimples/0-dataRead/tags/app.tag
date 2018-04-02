<app>

	<div each={ msg in messages }>{ msg.message }</div>

	<script>
		// Using tag as variable instead of that, maybe more clear.
		var tag = this;
		this.messages = []; // messages ary of THIS tag - starts empty.

		// READ Data at reference `/messages`
		var messagesRef = rootRef.child('messages');

		// Note, you must have some data in your database for this to work.
		// Also note that this listener is at the tag scope level.
		// It starts listening as soon as app.tag is initialized.
		messagesRef.on('value', function(snap){
			var dataAsObj = snap.val(); // Object representation of data.

			// Converts obj to array in alphabetical order by property name.
			// Alternate method to using a for loop to do it manually.
			tag.messages = Object.values(dataAsObj);
			tag.update(); // This is an async operation, must manually update() tag.
		});

	</script>

	<style>
		:scope {
			display: block;
		}
	</style>
</app>
