<mail-editor>
	<p>EDITOR</p>

	<div>
		<span>TO</span> <input type="text" ref="emailTo" value="">
	</div>
	<div>
		<span>SUBJECT</span> <input type="text" ref="emailSubject" value="">
	</div>

	<textarea name="name" ref="emailBody" rows="4" cols="40"></textarea>

	<button type="button" onclick={ sendMessage }>SEND</button>
	<button type="button" onclick={ parent.closeEditor }>CANCEL</button>

	<script>
		console.log(this);

		this.sendMessage = function(event) {
			var newEmail = {
				toEmail: this.refs.emailTo.value,
				subject: this.refs.emailSubject.value,
				body: this.refs.emailBody.value
			};
			this.parent.emailList.push(newEmail);
			this.parent.update();
			this.parent.closeEditor();
		};
	</script>

	<style>
		:scope {
			display: block;
			background-color: #333;
			color: white;
			border: 1px solid maroon;
			padding: 10px;
			position: fixed;
			right: 0;
			bottom: 0;
			width: 300px;
			height: 200px;
		}
		textarea {
			margin-top: 5px;
		}
	</style>
</mail-editor>
