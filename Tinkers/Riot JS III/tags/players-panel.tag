<players-panel>

	<!-- STATUS -->
	<div class="card">
		<div class="card-header">
			GOVERNMENT:
			<span hide={ president } class="badge badge-sm badge-warning">Nominated</span>
			<span show={ president } class="badge badge-sm badge-success">ELECTED</span>
		</div>
		<div class="card-body">
			<div>
				<strong>PRESIDENT:</strong> <span>{ nameOfPres }</span>
			</div>
			<div>
				<strong>CHANCELLOR:</strong> <span>{ nameOfChan }</span>
			</div>
		</div>
		<div class="card-footer">
			Election FAIL: <span class="badge badge-info">{ failCount }</span>
		</div>
	</div>

	<!-- ACTIONS -->
	<div class="card">
		<div class="card-header">
			PLAYERS
		</div>
		<div class="card-body">
			<chancellor-select if={ mode === "chancellor-select" } players={ players }></chancellor-select>
			<government-vote if={ mode === "government-vote" } players={ players }></government-vote>
		</div>
		<div class="card-footer">
			<button class="btn btn-dark" onclick={ toggleMode }>TOGGLE</button>
			<button class="btn btn-dark" onclick={ nominatePresident }>START ELECTION</button>
		</div>
	</div>

  <script>
    // JAVASCRIPT
		let tag = this;
		let numPlayers = opts.players.length;
		this.players = opts.players;

		this.nomination = true;
		this.failCount = 0;

		this.mode = "chancellor-select";

		this.nomineePres;
		this.nomineeChan;
		this.president;
		this.chancellor;
		this.nameOfPres = "";
		this.nameOfChan = "Please Select";

		// Shifts president-nominee to next, sets stage for chancellor selection.
		nominatePresident() {
			this.nameOfChan = "Please Select";

			// SET first PRESIDENT Nominee
			if (!this.president) { // FIRST ROUND
				let randIndex = Math.floor(Math.random() * numPlayers);
				this.lastElectedIndex = randIndex;
				this.nomineePres = this.players[randIndex];

			// SHIFT PRESIDENT Nominee to next player
			} else {
				let index;
				if (this.nomineePres) {
					index = this.players.indexOf(this.nomineePres);
				} else {
					index = this.players.indexOf(this.president);
				}

				if (index < numPlayers - 1) {
					this.nomineePres = this.players[index + 1];
				} else {
					this.nomineePres = this.players[0];
				}
			}

			this.nomineePres.nominated = true;
			this.nameOfPres = this.nomineePres.name;

			// We have a nomineePres
			// Move to next mode...

			this.mode = "chancellor-select";
			console.log(this.players);
		}

		this.nominatePresident();

		toggleMode() {
			if (this.mode === "chancellor-select") {
				this.mode = "government-vote";
			} else {
				this.mode = "chancellor-select";
			}
		}

		// OBSERVER Listners
		observer.on('chancellor:nominated', (player) => {
			this.nomineeChan = player;
			this.nameOfChan = player.name;

			this.mode = "government-vote";
			this.update();
		});

		observer.on('vote:completed', (electionSuccess) => {
			if (electionSuccess) {
				// Exiting president and chancellor
				if (this.president && this.chancellor) {
					this.president.termLimited = false;
					this.chancellor.termLimited = false;
				}

				// Set entering president and chancellor
				this.president = this.nomineePres;
				this.president.termLimited = true;
				this.president.nominated = false;
				this.chancellor = this.nomineeChan;
				this.chancellor.termLimited = true;
				this.chancellor.nominated = false;

				// Reset nominee president and chancellor and failcount
				this.nomineePres = undefined;
				this.nomineeChan = undefined;
				this.failCount = 0;

				this.mode = "default";
			} else {
				this.nominatePresident();
				this.failCount++;
			}

			if (this.failCount < 3) { // Society okay...
				alert('CONTINUE GAME');
			} else { // Societal upheaval!!!
				alert('ELECTION FAILED > THREE TIMES!');
			}
			this.update();
		});

  </script>

  <style>
    /* CSS */
		.card {
			display: block;
			margin: 1em 0;
		}
  </style>
</players-panel>
