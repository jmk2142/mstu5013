<comments-mine>
	<div class="comment" each={ myComments }>
		<button class="btn btn-mini btn-danger" onclick={ parent.deleteComment }>DELETE</button>
		<button class="btn btn-mini {btn-success:!public, btn-warning:public}" onclick={ parent.togglePublic }>{ public ? "UNPUBLISH" : "PUBLISH"}</button>
		&nbsp;&nbsp;<strong>{ author }</strong> :
		<span>{ message }</span>
	</div>

	<script>
		var that = this;

		this.user = firebase.auth().currentUser;
		this.myComments = [];

		var database = firebase.database();
		var myCommentsRef = database.ref('comments/users/' + this.user.uid);

		myCommentsRef.on('value', function(snapshot) {
			var commentsData = snapshot.val();

			// commentsData could be null (no results), then we cant get values -> error
			if (commentsData) {
				// Note - Object.values() does NOT work in safari.
				// if you want full cross-browser support, you need to convert
				// the object to an array with a traditional for in loop.
				that.myComments = Object.values(commentsData);
			} else {
				that.myComments = [];
			}
			that.update();
		});

		togglePublic(event) {
			var comment = event.item;
			comment.public = !comment.public;
			comment.modifiedAt = firebase.database.ServerValue.TIMESTAMP;

			var updates = {};

			// Look at what this does to the Data architecture on the DB.
			// What does toggling public do with regard to comments?
			if (comment.public) {
				updates['public/' + comment.id] = comment;
				updates['users/' + this.user.uid + '/' + comment.id] = comment;
			} else {
				updates['public/' + comment.id] = null;
				updates['users/' + this.user.uid + '/' + comment.id] = comment;
			}

			// One call to write to multiple locations
			database.ref('comments').update(updates);
		}

		this.deleteComment = function(event) {
			var comment = event.item;

			console.log(comment);

			var updates = {};
			updates['public/' + comment.id] = null;
			updates['users/' + this.user.uid + '/' + comment.id] = null;

			database.ref('comments').update(updates);
		};

		// Dummy listener
		// database.ref().on('value', function(snap){
		//   console.log('comments-mine: DUMMY Listener/Handler');
		// });
		// database.ref().on('value', function(snap){
		//   console.log('comments-mine: DUMMY Listener/Handler');
		// });
		// database.ref().on('value', function(snap){
		//   console.log('comments-mine: DUMMY Listener/Handler');
		// });

		// Removing event listeners
		this.on('unmount', function(event) {
		  myCommentsRef.off('value');
		});
		this.on('unmounted', function(event) {
			console.log('unmounted');
		});

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
