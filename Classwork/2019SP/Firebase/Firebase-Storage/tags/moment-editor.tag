<moment-editor>
  <!-- HTML -->
	<h2>Moment EDITOR</h2>

	<div class="row">
		<!-- Column ONE -->
		<div class="col">
			<h3>CREATE</h3>
			<form>
				<div class="form-group">
					<textarea class="form-control" ref="content" placeholder="Write about moment"></textarea>
				</div>

				<div class="custom-file">
					<input type="file" ref="media" class="custom-file-input" onchange={ handleFiles }>
					<label class="custom-file-label">{ fileLabel }</label>
				</div>

				<div class="form-group mt-3">
					<button class="btn btn-success" type="button" onclick={ save } disabled={ !file }>SAVE</button>
				</div>
			</form>
		</div>
		<!-- Column TWO -->
		<div class="col">
			<h3>PREVIEW</h3>
			<div if={ moment } class="card">
				<div class="card-header">Content: { moment.content }</div>
				<div class="card-body">
					<img if={ moment.mediaType.startsWith("image") } src="{ moment.mediaURL }">
					<video if={ moment.mediaType.startsWith("video") }>
						<source src="{ moment.mediaURL }" type="{ moment.mediaType }">
						Your browser does not support the video tag.
					</video>
				</div>
				<div class="card-footer">Author: { moment.author }</div>
			</div>
		</div>
	</div>

  <script>
    // JAVASCRIPT
		let momentsRef = database.collection('moments');
		let storageRef = firebase.storage().ref();
		let mediaStorageRef = storageRef.child('media');

		this.file = null;
		this.fileLabel = "Choose media file";

		handleFiles(event) {
			let fileInput = event.target;
			let files = fileInput.files; // Array of files data
			let file = files[0];         // One file (first)
			let fileName = file.name;    // e.g. happy-puppy.png
			let fileSize = file.size;    // e.g. 178955 (Bytes)
			let fileType = file.type;    // e.g. image/png

			this.file = file;
			this.fileLabel = fileName;
		}

		save() {
			let uniqueName = this.file.name + "-" + Date.now();
			let fileRef = mediaStorageRef.child(uniqueName);

			fileRef.put(this.file).then(snapshot => {
				console.log('UPLOADED File');
				return snapshot.ref.getDownloadURL();
			}).then(downloadURL => {
				let key = momentsRef.doc().id;

				this.moment = {
					author: firebase.auth().currentUser.displayName,
					mediaURL: downloadURL,
					mediaType: this.file.type,
					content: this.refs.content.value,
					id: key,
					createdAt: firebase.firestore.FieldValue.serverTimestamp()
				};

				return momentsRef.doc(key).set(this.moment);
			}).then( () => {
				console.log('SAVED to DATABASE');
				this.reset();
				this.update();
			});;
		}

		reset() {
			this.refs.content.value = "";
			this.refs.media.value = "";
			this.file = null;
			this.fileLabel = "Choose media file";
		}

  </script>

  <style>
    /* CSS */
    :scope {
    	display: block;
			margin-bottom: 3em;
    }
		img, video {
			width: 100%;
		}
  </style>
</moment-editor>
