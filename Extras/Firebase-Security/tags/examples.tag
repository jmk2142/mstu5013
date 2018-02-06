<examples>


	<script>
		var that = this;

		// We'll use this as an example
		const instructorID = "Mb3aS3KL-instructorID";

		var database = firebase.database();

		var friendsRef = database.ref('friends');
		var limitedRef = database.ref('limited');
		var privateRef = database.ref('private');
		var publicRef = database.ref('public');





		/* --------------------------------------------------
			FRIEND CODE - ADD/REMOVE from Jin's Friendlist
		-------------------------------------------------- */
		addAsFriends() {
			friendsRef.child(instructorID + '/' + that.user.uid).set(true);
		}
		removeFromFriends() {
			friendsRef.child(instructorID + '/' + that.user.uid).remove();
		}


		/* --------------------------------------------------
			AUTHENTICATION CODE
		-------------------------------------------------- */
		firebase.auth().onAuthStateChanged(function(userObj) {
			that.user = firebase.auth().currentUser;
			that.update();
		});

		signIn(event) {
			var provider = new firebase.auth.GoogleAuthProvider();
			firebase.auth().signInWithPopup(provider);
		}

		signOut(event) {
			firebase.auth().signOut();
		}


	</script>

	<style>
		:scope {
			display: block;
		}
	</style>
</examples>
