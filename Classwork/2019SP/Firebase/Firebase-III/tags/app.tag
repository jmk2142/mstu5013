<app>
	<navbar user={ user } room={ room }></navbar>

  <div class="container">
  	<div class="row">
  		<div class="col">
				<div if={ room }>
					<h1>Room: { room.id }</h1>
					<div each={ roomUser in roomUsers }>
						<strong>{ roomUser.name }</strong>: { roomUser.id }
						<div>
							<note each={ note, i in roomUser.notes } is-user={ (user.uid === roomUser.id) } room={ room } room-user={ roomUser }></note>
						</div>
					</div>
					<p>
						...are in the room.
					</p>
					<metronome></metronome>
				</div>
  		</div>
  	</div>
  </div>

  <script>
    // JAVASCRIPT
		let roomsRef = database.collection('sound-rooms');

		this.room = null;
		this.roomUsers = [];

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

		observer.on('exitRoom', () => {
			let roomUserRef = database.collection('sound-rooms').doc(this.room.id).collection('users').doc(this.user.uid);
			roomUserRef.delete().then(() => {
				this.room = null;
				this.update();
			});
		});

		observer.on('codeEntered', roomCode => {
			roomsRef.doc(roomCode).get().then(doc => {
				if (!doc.exists) {

					let room = {
						author: this.user.displayName,
						authorID: this.user.uid,
						id: doc.id
					}

					doc.ref.set(room);
					this.room = room;

				} else {
					let room = doc.data();
					this.room = room;
				}
				this.update();

				return doc;

			}).then(doc => {
				let roomUsersRef = doc.ref.collection('users');
				roomUsersRef.doc(this.user.uid).set({
					id: this.user.uid,
					name: this.user.displayName,
					notes: [
						{play:false},{play:false},{play:false},{play:false},
						{play:false},{play:false},{play:false},{play:false},
						{play:false},{play:false},{play:false},{play:false},
						{play:false},{play:false},{play:false},{play:false}
					]
				});
				return roomUsersRef;

			}).then(roomUsersRef => {
				stopListening = roomUsersRef.onSnapshot(querySnapshot => {
					this.roomUsers = [];
					querySnapshot.forEach(doc => {
						this.roomUsers.push(doc.data());
					});

					console.log(this.roomUsers);

					this.update();
				});
			});
		});

  </script>

  <style>
    /* CSS */
    :scope {}
  </style>
</app>
