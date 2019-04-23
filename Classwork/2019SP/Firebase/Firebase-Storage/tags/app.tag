<app>
  <!-- HTML -->
	<div class="container">
		<div class="row">
			<div class="col">
				<!-- LOGGED OUT -->
				<div if={ !user } ref="loggedOut">
					<h1 class="mb-5">
						You are logged out.
						<button type="button" onclick={ logIn }>LOGIN</button>
					</h1>
				</div>

				<!-- LOGGED IN -->
				<div if={ user } ref="loggedIn">
					<h1 class="mb-5">
						You are logged in:
						<button type="button" onclick={ logOut }>LOGOUT</button>
					</h1>

					<moment-editor></moment-editor>

					<h2>COLLECTION</h2>
					<div ref="moment-list">
						<!-- moments go here -->
						<moment each={ moment in moments }></moment>
					</div>
				</div>
			</div>
		</div>
	</div>




  <script>
    // JAVASCRIPT
		this.user;
		this.moments = [];

		logIn() {
	    var provider = new firebase.auth.GoogleAuthProvider();
	    firebase.auth().signInWithPopup(provider);
		}

		logOut(){
			firebase.auth().signOut();
		}

		let stopListening = () => false;

		// Firebase authentication state listener
		firebase.auth().onAuthStateChanged(userObj => {
		  if (userObj) {
		    this.user = userObj;
				// start data listening
				stopListening = database.collection('moments').onSnapshot(snapshot => {
					this.moments = [];
					snapshot.forEach(doc => {
						this.moments.push(doc.data());
					});
					this.update();
				});
		  } else {
		    this.user = null;
				stopListening();
		  }
			this.update();
		});

  </script>

  <style>
    /* CSS */
    :scope {}
  </style>
</app>
