<comments-public>
	<div class="comment" each={ publicComments }>
		<strong>{ author }</strong> :
		<span>{ message }</span>
	</div>

	<script>
		var that = this;
		this.publicComments = [];

		var database = firebase.database();
		var publicCommentsRef = database.ref('comments/public');

		publicCommentsRef.on('value', function(snapshot) {
			var commentsData = snapshot.val();

			if (commentsData) {
				// What does Object.values() do?
				// E.g. Object.values({a:1, b:2, c:3});
				// Note: Object.values() is still experimental.
				that.publicComments = Object.values(commentsData);
			} else {
				that.publicComments = [];
			}
			that.update();
		});

		this.on('unmount', function(event) {
		  publicCommentsRef.off('value');
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
</comments-public>
