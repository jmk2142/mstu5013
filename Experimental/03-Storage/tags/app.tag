<app>
	<h1 class="page-header">Storage</h1>
	<form class="form-inline">
	  <div class="form-group">
	    <label>Title</label>
	    <input type="text" ref="title" class="form-control" value="" placeholder="Enter Title">
	  </div>&nbsp;
	  <div class="form-group">
	    <label>Caption</label>
	    <input type="text" ref="caption" class="form-control" value="" placeholder="Enter Caption">
	  </div>
		<div class="form-group">
			<label class="btn { btn-default:!file, btn-info:file } btn-file">
				{ file ? file.name : "Browse" }
				<!-- Note, I do some 'fancy' css to make the file input look better, but you don't need any of this except for the input line. -->
				<input type="file" ref="photoFile" onchange={ fileSelected }>
			</label>
		</div>

	  <button type="button" class="btn btn-success" onclick={ savePhoto }>Save</button>
	</form>

	<!-- GALLERY -->
	<h2>Gallery</h2>
	<div class="row">
		<!-- Photos -->
		<div class="col-xs-4 col-sm-4">
			<photo each={ photos.filter(colA) }></photo>
		</div>
		<div class="col-xs-4 col-sm-4">
			<photo each={ photos.filter(colB) }></photo>
		</div>
		<div class="col-xs-4 col-sm-4">
			<photo each={ photos.filter(colC) }></photo>
		</div>
	</div>

	<script>
		var that = this;
		this.photos = [];
		this.file = null;

		// Pretend user is an authenticated user with uid
		var user = {
			displayName: "Jin Kuwata",
			uid: "Mfi93sif245islf24xY"
		};

		// Really, just like database
		var database = firebase.database();
		var storage = firebase.storage();

		// References, just like database refs
		var photosRef = database.ref('photos');
		var imageFilesRef = storage.ref('images');
		var myImagesRef = imageFilesRef.child(user.uid);
		// e.g. 'images/users/userID/photo.jpg'

		photosRef.on('value', function(snapshot) {
			var data = snapshot.val();
			if (data) {
				data = Object.values(data);
				that.photos = data;
				console.log(that.photos);
			}
			that.update();
		});

		fileSelected(event){
			var file = this.refs.photoFile.files[0];
			console.log('File Object:', file); // See for properties
			this.file = file;
		}

		savePhoto(event) {
			if (this.file) {

				// SAVE THE FILE to STORAGE
				myImagesRef.child(this.file.name).put(this.file).then(function(response) {
					// FILE is now saved...
					// The downloadURL is in the response...
					console.log(response.downloadURL);

					// We could save the associated data about the file now...
					var key = photosRef.push().key;

					var photo = {
						id: key,
						author: user.displayName,
						authorID: user.uid,
						title: that.refs.title.value,
						caption: that.refs.caption.value,
						photoURL: response.downloadURL
					};

					photosRef.child(key).set(photo);

					// Reset the form.
					that.file = null;
					that.refs.title.value = "";
					that.refs.caption.value = "";
					that.update();
				});

			} else {
				alert('Please Select a File');
			}
		}

		// Filtering function for columns
		colA(item, index, list) {
			return index % 3 === 0;
		}
		colB(item, index, list) {
			return index % 3 === 1;
		}
		colC(item, index, list) {
			return index % 3 === 2;
		}

		/*
		This function just creates a random unique ID. We could use something like this to randomly assign a unique filename for our file. It isn't a necessary step, we don't use it in our example here. You can name a file anything you want. For example: myImage.jpg, [timestamp].jpg. But if you try to save a file with the same name to the same location ref, it will overwrite. E.g. (PhotoB named image.jpg written to ref) -> /images/user/userA/image.jpg will overwrite (PhotoB named image.jpg written to ref) -> /images/user/userA/image.jpg
		http://stackoverflow.com/questions/105034/create-guid-uuid-in-javascript
		*/
		function generateUUID () { // Public Domain/MIT
			var d = new Date().getTime();
			if (typeof performance !== 'undefined' && typeof performance.now === 'function'){
			    d += performance.now(); //use high-precision timer if available
			}
			return 'xxxxxxxx-xxxx-4xxx-yxxx-xxxxxxxxxxxx'.replace(/[xy]/g, function (c) {
			    var r = (d + Math.random() * 16) % 16 | 0;
			    d = Math.floor(d / 16);
			    return (c === 'x' ? r : (r & 0x3 | 0x8)).toString(16);
			});
		}


	</script>

	<style>
		:scope {
			display: block;
		}
		input[type="file"] {
			display: none;
		}
		.btn-file {
			position: relative;
			overflow: hidden;
		}
		.btn-file input[type="file"] {
			position: absolute;
			top: 0;
			right: 0;
			min-width: 100%;
			min-height: 100%;
			font-size: 100px;
			text-align: right;
			filter: alpha(opacity=0);
			opacity: 0;
			outline: none;
			background: white;
			cursor: inherit;
			display: block;
		}
	</style>
</app>
