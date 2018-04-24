<app>

	<button type="button" onclick={ signIn } if={ !loggedIn }>SIGN IN</button>
	<button type="button" onclick={ signOut } if={ loggedIn }>SIGN OUT</button>

	<div if={ loggedIn }>
		<p>THIS IS A USER PAGE.</p>
		<p>Here are your lovely tweets.</p>
		<small>Instead of a div, this could have been a component.</small>
	</div>

	<div if={ !loggedIn }>
		<p>THIS IS THE SPLASH PAGE.</p>
		<p>Please register with Google!</p>
		<small>Instead of a div, this could have been a component.</small>
	</div>

	<script>
		var tag = this;
		console.log('app.tag');

		// We use this tag state to toggle the signin button/page on/off
		this.loggedIn = false;

		// We setup the listener that will listen for auth state changes.
		// Notice I'm placing it at the tag level, it starts listening as soon as
		// app.tag loads.
		// It will automatically trigger when you first initialize this tag giving you
		// either a user object or null. Login sessions continue across the browser
		// closed state. So if they open up the page, they'll resume where they left off.
		// E.g. logged in if they were signed in, out if they were signed out.

		firebase.auth().onAuthStateChanged(function(user) {

				// user argument will be a user object if authenticated session still exists.
				// user argument will be null if authenticated session is closed.

			if (user) {
				tag.loggedIn = true;
			} else {
				tag.loggedIn = false;
			}

			// Don't forget to update the tag manually. Riot is not privy to what happens
			// in this callback function.

			tag.update();
		});

		// Our handler function to the button click.
		signIn(e) {

			// The only code needed for Google authentication. 2 lines!
			var provider = new firebase.auth.GoogleAuthProvider();
	    firebase.auth().signInWithPopup(provider);
		}

		// Handler function to the button click.
		signOut(e) {
			firebase.auth().signOut();
			// console.log(firebase.auth().currentUser); --> NULL, remember --> ASYNC
			// This is why we need to setup the .onAuthStateChanged listener.
		}
	</script>

	<style>
		:scope {
			display: block;
		}
	</style>
</app>
