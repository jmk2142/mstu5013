<message>

	<div>{ msg.author } says: { msg.message } &hellip;
		<button onclick={ deleteMsg }>DELETE</button>
	</div>

	<script>
		var tag = this;

		// Since DELETE is a function that we want on each message item, it makes a lot of sense for the message.tag to have the delete UI and code.

		deleteMsg(e) {
			// Each message tag was passed to it, a message model as `msg`
			// See app.tag `<message each={ msg in messages }></message>`
			var model = this.msg;

			// Each message model has an `id`
			// Each message model also has the username/userID as `uid`
			// See app.tag, `saveMsg(e){...}` code.
			var key = model.id;

			var refLocations = {};
					refLocations['messages/' + key] = null;
					refLocations['messagesByUser/' + model.uid + '/' + key] = null;

			// Instead of using `.remove()` each time at each ref,
			// we use `.update()` to set multiple ref locations to null at once.

			rootRef.update(refLocations);
		}
	</script>

	<style>
		:scope {
			display: block;
		}
	</style>
</message>
