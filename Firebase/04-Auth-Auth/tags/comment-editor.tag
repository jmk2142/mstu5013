<comment-editor>
	<label>Post a Comment</label>
	<input type="text" class="form-control" ref="comment" placeholder="Enter Comment" onkeypress={ saveComment }><br>
	<button class="btn btn-primary" onclick={ saveComment }>POST</button>

	<script>
		var that = this;
		var database = firebase.database();

		// This reference is important - see database for architecture
		var myCommentsRef = database.ref('comments/users/' + user.uid);

		saveComment(event){
			if ((event.type === "keypress" && event.which === 13) || event.type === "click") {

				var key = myCommentsRef.push().key;
				var comment = {
					id: key, // Save copy of commentID into my object - easier
					userID: user.uid, // global Google authenticated user object
					author: user.displayName,
					message: this.refs.comment.value,
					public: false,
					createdAt: firebase.database.ServerValue.TIMESTAMP,
					modifiedAt: firebase.database.ServerValue.TIMESTAMP
				};
				myCommentsRef.child(key).set(comment).then(function(result){
				  console.log(result);
				}).catch(function(error){
				  console.log(error.message);
				});

				this.reset();
			}
		}

		reset() {
			this.refs.comment.value = "";
			this.refs.comment.focus();
		}
	</script>

	<style>
		:scope {
			display: block;
			border: 1px solid #DDD;
			border-radius: 4px;
			padding: 15px;
		}
	</style>
</comment-editor>
