<moment>
  <!-- HTML -->
	<div class="card">
		<div class="card-header">Content: { moment.content }</div>
		<div class="card-body">
			<img if={ moment.mediaType.startsWith("image") } src="{ moment.mediaURL }">
			<video if={ moment.mediaType.startsWith("video") } autoplay loop muted>
				<source src="{ moment.mediaURL }" type="{ moment.mediaType }">
				Your browser does not support the video tag.
			</video>
		</div>
		<div class="card-footer">
			Author: { moment.author }
			<button type="button" onclick={ delete }>DELETE</button>
		</div>
	</div>

  <script>
    // JAVASCRIPT
		delete() {
			let storageRef = firebase.storage().refFromURL(this.moment.mediaURL);
			let momentRef = database.collection('moments').doc(this.moment.id);

			storageRef.delete().then(() => {
			  console.log('file deleted');
				return momentRef.delete();
			}).then(() => {
				console.log('data deleted');
			});
		}
  </script>

  <style>
    /* CSS */
    :scope {
    	display: inline-block;
			width: 300px;
			margin-right: 1em;
			margin-bottom: 1em;
    }
		img, video {
			width: 100%;
		}
  </style>
</moment>
