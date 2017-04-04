<photo>
	<div class="thumbnail">
		<a href={ photoURL }>
			<img src={ photoURL }>
		</a>
		<div class="caption">
			<h3>{ title || "Untitled" }</h3>
			<p>{ caption || "No Caption" }</p>
			<small>By { author }</small>
		</div>
		<button class="btn btn-danger" onclick={ deletePhoto }><i class="fa fa-lg fa-trash"></i></button>

	</div>

	<script>
		var that = this;

		var photoRef = firebase.database().ref('photos');
		var storage = firebase.storage();

		deletePhoto(event) {
			var photoData = event.item;
			var imageRef = storage.refFromURL(event.item.photoURL);

			// Delete Image File
			imageRef.delete().then(function() {
				// Delete photo data, once image file is deleted
				photoRef.child(photoData.id).remove();
			});
		}
	</script>

	<style>
		:scope {
			display: block;
			position: relative;
		}
		button.btn-danger {
			display: block;
			position: absolute;
			top: 15px;
			right: 15px;
		}
	</style>
</photo>
