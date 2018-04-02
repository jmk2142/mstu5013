<message>

	<div>{ msg.author } says: { msg.message } &hellip;
		<button onclick={ editMsg } hide={ editing }>EDIT</button>

		<div if={ editing }>
			<textarea rows="8" ref="msgTextArea">{ msg.message }</textarea>
			<button type="button" onclick={ changeMsg }>CHANGE</button>
			<button type="button" onclick={ cancel }>CANCEL</button>
		</div>
	</div>

	<script>
		var tag = this;

		this.editing = false; // MODE toggle

		editMsg(e) {
			this.editing = true;
		}

		cancel(e) {
			this.editing = false;
		}

		changeMsg(e) {
			this.msg.message = this.refs.msgTextArea.value;

			var refLocations = {};
					refLocations['messages/' + this.msg.id] = this.msg;
					refLocations['messagesByUser/' + this.msg.uid + '/' + this.msg.id] = this.msg;

			rootRef.update(refLocations);
		}

	</script>

	<style>
		:scope {
			display: block;
		}
	</style>
</message>
