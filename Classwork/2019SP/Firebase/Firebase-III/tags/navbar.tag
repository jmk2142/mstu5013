<navbar>
  <!-- HTML -->
	<nav class="navbar navbar-expand-lg navbar-light bg-light">
	  <a class="navbar-brand" href="#">Social Sound</a>
	  <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarSupportedContent" aria-controls="navbarSupportedContent" aria-expanded="false" aria-label="Toggle navigation">
	    <span class="navbar-toggler-icon"></span>
	  </button>

	  <div class="collapse navbar-collapse" id="navbarSupportedContent">
	    <ul class="navbar-nav mr-auto">
	    </ul>
	    <div class="form-inline my-2 my-lg-0">
				<span if={ user } class="navbar-text mr-3">{ user.displayName }</span>
				<input if={ user && !room } class="form-control mr-sm-2" ref="roomCode" placeholder="Room Code" onkeypress={ enterRoomCode }>
				<button show={ room } class="btn btn-outline-warning my-2 my-sm-0 mr-sm-2" type="button" onclick={ exitRoom }>Exit Room</button>
	      <button show={ !user } class="btn btn-outline-success my-2 my-sm-0" type="button" onclick={ login }>Login</button>
				<button show={ user } class="btn btn-outline-danger my-2 my-sm-0" type="button" onclick={ logout }>Logout</button>
	    </div>
	  </div>
	</nav>

  <script>
		login() {
			var provider = new firebase.auth.GoogleAuthProvider();
			firebase.auth().signInWithPopup(provider);
		}
		logout() {
			firebase.auth().signOut();
		}
		exitRoom() {
			observer.trigger('exitRoom');
		}

		enterRoomCode(event) {
			if (event.code === "Enter") {
				let roomCode = event.target.value;
				observer.trigger('codeEntered', roomCode);
			}
		}

		this.on('update', () => {
			this.user = opts.user;
			this.room = opts.room;
		});
  </script>

  <style>
    /* CSS */
    :scope {}
    .special {
      background-color: #333333;
      color: #FFFFFF;
    }
  </style>
</navbar>
