<comments-mine>
	<p>LIST OF MY COMMENTS</p>
	<div class="comment" each={ myComments }>
		<button class="btn btn-mini {btn-success:!public, btn-warning:public}" onclick={ parent.togglePublic }>{ public ? "UNPUBLISH" : "PUBLISH"}</button>
		<button class="btn btn-mini btn-danger" onclick={ parent.deleteComment }>DELETE</button>
		<strong>{ user.displayName }</strong> :
		<span>{ message }</span>

	</div>

	<script>
		var that = this;
		this.myComments = [];

		var database = firebase.database();
		var myCommentsRef = database.ref('comments/users/' + user.uid);
		var publicCommentsRef = database.ref('comments/public');

		myCommentsRef.on('value', function(snapshot) {
			var commentsData = snapshot.val();

			// commentsData could be null (no results), then we cant get values -> error
			if (commentsData) {
				that.myComments = Object.values(commentsData);
			} else {
				that.myComments = [];
			}
			that.update();
		});

		togglePublic(event) {
			var comment = event.item;
			comment.public = !comment.public;

			var updates = {};

			// Look at what this does to the Data architecture on the DB.
			// What does toggling public do with regard to comments?
			if (comment.public) {
				updates[`comments/public/${comment.id}`] = comment;
				updates[`comments/users/${user.uid}/${comment.id}`] = comment;
			} else {
				updates[`comments/public/${comment.id}`] = null;
				updates[`comments/users/${user.uid}/${comment.id}`] = comment;
			}

			database.ref().update(updates);
		}

		this.deleteComment = function(event) {
		  console.log('deleteComment', event.item);
		};

	</script>

	<style>
		:scope {
			display: block;
		}
		form {
			padding-bottom: 15px;
		}
		.comment {
			background-color: #F5F5F5;
			padding: 15px;
		}
		.comment:nth-child(even) {
			background-color: #DDDDDD;
		}
	</style>
</comments-mine>
