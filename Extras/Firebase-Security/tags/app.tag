<app>

	<div class="row">
		<div class="s12">
			<h1>Security: Database Rules</h1>
			<div class="divider"></div>
			<div class="section">
				<button class="btn green" onclick={ signIn } if={ !user }>LOGIN</button>
				<button class="btn red" onclick={ signOut } if={ user }>LOGOUT</button>
				&nbsp;&nbsp;<span>{ user ? user.displayName : "" }</span>
			</div>
			<div class="divider"></div>

			<div class="section">
				<div class="row">
					<div class="input-field col s6">
						<input id="animalName" type="text" ref="animalInput" onkeypress={ makeAnimal }>
						<label for="animalName">Animal</label>
					</div>
				</div>
				<button class="btn light-blue" onclick={ makeAnimal }>MAKE Animal</button>
				<button class="btn light-blue" onclick={ makeUserAnimal }>MAKE User/Animal</button>
			</div>
			<div class="divider"></div>
			<div class="section">
				<button class="btn light-blue" onclick={ getAnimals }>GET Animals</button>
			</div>
			<div class="divider"></div>
			<div class="section">
				<pre>{ JSON.stringify(animals, null, 2) }</pre>
			</div>
		</div>
	</div>

	<script>
		var that = this;

		var database = firebase.database();
		var animalsRef = database.ref('animals');
		var usersRef = database.ref('users');

		this.animals = [];
		this.user = null;

		/* --------------------------------------------------
			FIREBASE RULE KEYWORDS

			.read, .write, .validate

			$someWildcard

			auth, auth.uid
			data, newData

			.exists()
			.val()
		-------------------------------------------------- */

		/* --------------------------------------------------
			WRITE CODE
		-------------------------------------------------- */
		makeAnimal(event) {
			var animal = {};
			if (event.type === "keypress" && event.which !== 13) {
				return; // Don't run except for on ENTER keypress
			}

			animal.name = this.refs.animalInput.value.toLowerCase();

			this.refs.animalInput.value = "";

			var key = animalsRef.push().key;
			animal.id = key;

			animal.uid = this.user ? this.user.uid : "";
			animal.author = this.user ? this.user.displayName : "";

			animalsRef.child(key).set(animal);
		}

		makeUserAnimal(event) {
			var animal = {};
			animal.name = this.refs.animalInput.value.toLowerCase();
			this.refs.animalInput.value = "";

			// FAKING another user's UID
			const jinUserID = "MpbQb5PEAEe93gzkMJ4jndsW1IF2";

			var key = usersRef.child(jinUserID).push().key;
			animal.id = key;

			animal.uid = this.user ? this.user.uid : "";
			animal.author = this.user ? this.user.displayName : "";

			usersRef.child(jinUserID + '/' + key).set(animal);
		}

		/* --------------------------------------------------
			READ CODE
		-------------------------------------------------- */
		getAnimals(event) {
			animalsRef.once('value', function(snap){
				var data = snap.val();
			  that.animals = Object.values(data);
				that.update();
			}).catch(function(error){
			  console.error(error);
			});
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
</app>
