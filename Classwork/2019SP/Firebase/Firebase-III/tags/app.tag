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

				<div class="form-group">
					<input show={ user } class="form-control" ref="code" placeholder="Enter Code > Press Enter" onkeypress={ enterCode }>
				</div>

				<sound-pad each={ sound in sounds }></sound-pad>

			</div>
		</div>
	</div>


  <script>
		this.user = null;

		const SOUNDS = [
			"snareA.wav",
			"snareB.wav"
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

				database.collection('sound-rooms').doc(event.code).set({
					author: this.user.displayName,
					owner: this.user.uid,
					soundPlayed: false
				});

				this.reset();
			}
		}
		reset() {
			this.refs.code.value = "";
		}

		firebase.auth().onAuthStateChanged(userObj => {
		  if (userObj) {
		    this.user = userObj;
		  } else {
		    this.user = null;
		  }
			this.update();
		});


  </script>

  <style>
    /* CSS */
    :scope {}
    .special {
      background-color: #333333;
      color: #FFFFFF;
    }
		div {
			/* height: 2em; */
		}
		small {
			font-size: 0.75em;
		}
  </style>
</app>
