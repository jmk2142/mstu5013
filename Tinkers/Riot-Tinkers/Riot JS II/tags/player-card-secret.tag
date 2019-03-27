<player-card-secret class="card">
	<div class="card-header">
		<strong>{ name }</strong>
	</div>
	<div class="card-body">
		<div show={ !reveal }>
			<img src="./assets/game/card-role-unknown.jpg">
		</div>
		<div show={ reveal }>
			<img if={ !hitler } src="./assets/game/card-role-{ party }.jpg">
			<img if={ hitler } src="./assets/game/card-role-hitler.jpg">
			<strong>INTEL:</strong>
			<div>{ intel }</div>
		</div>
	</div>
	<div class="card-footer">
		<button show={ !seen || sealed } class="btn btn-dark" onclick={ showIdentity } disabled={ sealed || opts.inReview }>{ sealed ? "SEALED" : "REVEAL" }</button>
		<button show={ seen && !sealed } class="btn btn-danger" onclick={ hideIdentity }>CONCEAL</button>
	</div>


  <script>
    // JAVASCRIPT
    let tag = this;

		this.reveal = false;
		this.seen = false;
		this.sealed = false;
		this.intel = "";

		/********************
		Executes at the start of each player-card-secret creation/initialization
		********************/
		let allPlayers = this.parent.players;
		let playersNotMe = allPlayers.filter(player => {
			return player.name !== tag.name;
		});

		// This code generates the INTEL text for this card. At start of initialization.
		if (this.parent.numPlayers < 7) {
			playersNotMe.forEach(otherPlayer => {
				if (tag.party === "fascist") {
					if (otherPlayer.party === "fascist") {
						this.intel += otherPlayer.hitler ? `${otherPlayer.name.toUpperCase()} is HITLER.\n` : `${otherPlayer.name.toUpperCase()} is a FASCIST.\n`;
					}
				} else {
					this.intel = "No additional intel."
				}
			});
		} else {
			playersNotMe.forEach(otherPlayer => {
				if (tag.party === "fascist" && !tag.hitler) {
					if (otherPlayer.party === "fascist") {
						this.intel += otherPlayer.hitler ? `${otherPlayer.name.toUpperCase()} is HITLER.\n` : `${otherPlayer.name.toUpperCase()} is a FASCIST.\n`;
					}
				} else {
					this.intel = "No additional intel."
				}
			});
		}

		/********************
		Tag instance methods
		********************/
		showIdentity(event) {
			event.preventUpdate = true;
			this.reveal = true;
			this.seen = true;

			let player = event.item;
			player.ready = true;

			this.parent.toggleInReview(true);
		}
		hideIdentity(event) {
			event.preventUpdate = true;
			this.reveal = false;
			this.sealed = true;
			this.parent.toggleInReview(false);
		}

  </script>

  <style>
    /* CSS */
    :scope {
    	display: block;
    	width: 18rem;
			margin: 1em;
    }
		img {
			width: 100%;
		}
  </style>
</player-card-secret>
