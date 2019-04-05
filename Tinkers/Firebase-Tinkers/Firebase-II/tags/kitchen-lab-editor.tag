<kitchen-lab-editor>
  <!-- HTML -->
  <h3>Create a new laboratory:</h3>
	<input ref="labName" value="" placeholder="Lab name:">
	<input ref="labKeywords" value="" placeholder="Keywords: Comma separated" onkeypress={ loginEnter }>
	<button type="button" onclick={ createLab }>CREATE LAB</button>

  <script>
    // JAVASCRIPT
		this.user = opts.user;

		createLab(event) {
			let keywords = this.refs.labKeywords.value;
					keywords = keywords.split(',');
					keywords = keywords.map(phrase => {
						return phrase.toLowerCase().replace(/[^a-zA-Z0-9]/g, '').replace(/\s/g, '');
					});

			let lab = {
				name: this.refs.labName.value,
				owner: this.user.username,
				timestamp: firebase.firestore.FieldValue.serverTimestamp(),
				keywords: keywords
			};

			let labRef = database.collection('kitchen-labs').doc();
			let labID = labRef.id;

			let kitchenLabRef = database.collection('kitchen-labs').doc(labID);
			let userLabRef = database.collection('kitchen-users').doc(this.user.username).collection('labs').doc(labID);

			let batch = database.batch();
					batch.set(kitchenLabRef, lab);
					batch.set(userLabRef, lab);

					batch.commit().then(() => {
						console.log("Batched job: WRITE, to 2 locations successful.");
					});

			this.reset();
		}

    loginEnter(event) {
			if (event.code === "Enter") {
				this.createLab();
			}
		}

		reset() {
			this.refs.labName.value = "";
			this.refs.labKeywords.value = "";
		}
  </script>

  <style>
    /* CSS */
    :scope {
    	display: block;
    	margin-bottom: 4em;
    }
  </style>
</kitchen-lab-editor>
