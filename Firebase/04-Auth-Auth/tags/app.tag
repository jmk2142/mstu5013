<app>
	<h1 class="page-header">
		Authentication and Authorization
		<button if={ !user } class="btn btn-success pull-right" onclick={ logIn }>LOGIN</button>
		<button if={ user } class="btn btn-danger pull-right" onclick={ logOut }>LOGOUT</button>
	</h1>

	<home if={ !user }></home>
	<members if={ user }></members>

	<script>
		var that = this;
		this.user = user; // Comes from the global user.

		/* --------------------------------------------------
			AUTHENTICATION -> firebase.auth()
			1) onAuthStateChanged()
			2) signInWithPopup()
			3) signOut()

			ATOMIC WRITES
			1) ref.update(updateObject)
			2) See data architecture implications

			AUTHORIZATION
			1) Rules and cascades
			2) Keywords
				- auth
				- $something
				- data
				- newData
		-------------------------------------------------- */


		// AUTHENTICATION LISTENER
		// Once we code this, we have a "live" listener that is constantly listening for whether the user is logged in or not. It will fire the callback if it "hears" a login, or logout.
		firebase.auth().onAuthStateChanged(function(userObj) {
			if (userObj) {
				// User is signed in.
				that.user = userObj;
				user = that.user; // set global user
			} else {
				// User is not signed in.
				that.user = null;
			}
			that.update();
		});

		logIn(event) {
			// Specify that you want to sign up with Google authentication
			var provider = new firebase.auth.GoogleAuthProvider();

			// Popover signup is probably the most simple and trusted.
			firebase.auth().signInWithPopup(provider).then(function (result) {

				// Setting it to global user for convenience.
				user = result.user;

			}).catch(function (error) {
				// Handle Errors here.
				console.log('Error:', error.code, error.message);
				console.log('Email of account used:', error.email);
				console.log('Credential type used:', error.credential);
			});
		}

		logOut(event) {
			firebase.auth().signOut().then(function() {
				// Sign-out OK - nothing really important here.
				// Remember, we have the auth listener in app.tag
			}).catch(function(error) {
				// An error happened.
			});
		}

		this.on('update', function(event) {
			console.log('app.tag update');
		});

	</script>

	<style>
		:scope {
			display: block;
		}
	</style>
</app>
