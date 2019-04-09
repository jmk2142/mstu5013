<app>
  <!-- HTML -->
	<div class="container">
		<div class="row">
			<div class="col">
				<h1>
					Social Sounds
					<span class="float-right">
						<button hide={ user } class="btn btn-success" onclick={ login }>LOGIN</button>
						<small if={ user }>{ user.displayName }
							<button class="btn btn-danger" onclick={ logout }>LOGOUT</button>
						</small>
					</span>
				</h1>

				<div hide={ room } class="form-group">
					<h2>Room Code</h2>
					<input show={ user } class="form-control" ref="code" placeholder="Enter Code > Press Enter" onkeypress={ enterCode }>
				</div>

				<sound-room if={ room } room={ room } user={ user } people={ people }></sound-room>

			</div>
		</div>
	</div>


  <script>
		this.user = null;
		this.room;

		this.people = [];

		const SOUNDS = [
			"snareA.wav",
			"snareB.wav",
			"get-outta-here.mp3",
			"credulous.mp3",
			"glass-breaking.mp3",
			"just-like-magic.mp3",
			"filling-your-inbox.mp3",
			"oringz-w468.mp3"
		];

		this.sounds = [];

		for (soundFile of SOUNDS) {
			this.sounds.push(new Audio(`./sounds/${ soundFile }`));
		}

    // JAVASCRIPT
		login() {
	    var provider = new firebase.auth.GoogleAuthProvider();
	    firebase.auth().signInWithPopup(provider);
		}
		logout() {
			firebase.auth().signOut();
		}

		enterCode(event) {
			if (event.code == "Enter") {
				let code = event.target.value;

				database.collection('sound-rooms').doc(code).get().then(doc => {
					if (!doc.exists) {

						let room = {
							author: this.user.displayName,
							owner: this.user.uid,
							soundPlayed: false,
							people: {},
							id: doc.id
						};

						room.people[this.user.uid] = {
							name: this.user.displayName,
							notes: this.getUserNotes()
						};

						doc.ref.set(room);
						this.room = room;

						console.log("Room does not exist: CREATED");

					} else {
						this.room = doc.data();

						if (!this.room.people[this.user.uid]) {
							let updates = {};
							updates["people." + this.user.uid] = {
								name: this.user.displayName,
								notes: this.getUserNotes()
							};

							doc.ref.update(updates);
						}

						console.log("Room exists: JOINED");
					}
				}).then( () => {
					this.startListening();
					this.update();
				});

				this.reset();
			}
		}
		reset() {
			this.refs.code.value = "";
		}

		getUserNotes() {
			let notesList = [];
			for (let i=0; i < 16; i++) {
				notesList.push({
					sound: 'default',
					pitch: 0,
					duration: 0
				});
			}
			return notesList;
		}

		firebase.auth().onAuthStateChanged(userObj => {
		  if (userObj) {
		    this.user = userObj;
		  } else {
		    this.user = null;
				this.room = null;
		  }
			this.update();
		});

		let stopListening;

		startListening() {
			stopListening = database.collection('sound-rooms').doc(this.room.id).onSnapshot(doc => {
				if (!doc.exists) {
					this.room = null;
					stopListening();
					this.update();
				} else {
					let data = doc.data();
					this.people = [];

					for (let key in data.people) {
						let person = data.people[key];
								person.id = key;

						this.people.push(data.people[key]);
					}

					console.log('update');
					this.update();
				}
			});
		}


  </script>

  <style>
    /* CSS */
    :scope {}
    h1 {
      border-bottom: 2px solid silver;
			padding-bottom: 1em;
			margin-bottom: 1em;
    }
		div {
			/* height: 2em; */
		}
		small {
			font-size: 0.75em;
		}
  </style>
</app>
