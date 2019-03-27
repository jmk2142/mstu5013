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
			<div if={ mode === "default" } >
				<p>Players are doing other things.</p>
				<p>Press Start Election to rerun cycle.</p>
			</div>
		</div>
		<div class="card-footer">
			<div show={ mode === "chancellor-select" }>
				<strong>{ nameOfPres }</strong>, nominate a Chancellor.
			</div>
			<div show={ mode === "government-vote" }>
				<em>Everyone</em> please vote.
			</div>
			<!-- <button class="btn btn-dark" onclick={ toggleMode }>TOGGLE</button> -->
			<button show={ mode === "default" } class="btn btn-dark" onclick={ nominatePresident }>START ELECTION</button>
		</div>
	</div>

  <script>
    // JAVASCRIPT
		let tag = this;
		let numPlayers = opts.players.length;
		this.players = opts.players;

		this.failCount = 0;
		this.mode = "chancellor-select";

		this.nomineePres;
		this.nomineeChan;
		this.president;
		this.chancellor;
		this.nameOfPres = "";
		this.nameOfChan = "Please Select";

		// Shifts president-nominee to next, sets stage for chancellor selection.
		nominatePresident(failedNominee) {
			this.nameOfChan = "Please Select";

			// SET first PRESIDENT Nominee
			if (!this.president && !failedNominee) { // FIRST ROUND
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
		}

		this.nominatePresident(); // STARTS the first election round...





		// OBSERVER Listeners
		observer.on('chancellor:nominated', (player) => {
			this.nomineeChan = player;
			this.nameOfChan = player.name;

			this.mode = "government-vote";
			this.update();
		});

		observer.on('vote:completed', (electionSuccess) => {

			// ---------- ELECTION SUCCESSFUL
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

			// ---------- ELECTION UNSUCCESSFUL
			} else {

				this.nomineePres.nominated = false;
				this.nomineeChan.nominated = false;

				this.failCount++;

				if (this.failCount < 3) { // Society okay...
					this.nominatePresident(this.nomineePres);
				} else { // Societal upheaval!!!
					alert('ELECTION FAILED > THREE TIMES!');

					/********************
					If the group rejects three
					governments in a row, the country is thrown into
					chaos. Immediately reveal the Policy on top of
					the Policy deck and enact it. Any power granted
					by this Policy is ignored, but the Election
					Tracker resets, and existing term-limits are
					forgotten. All players become eligible to hold
					the office of Chancellor for the next Election.
					If there are fewer than three tiles remaining in
					the Policy deck at this point, shuffle them with
					the Discard pile to create a new Policy deck.
					********************/

					// Draw and enact next policy
					// Ignore any power granted
					// Reset failCount
					// Reset all termLimits
					// Shuffle if less than three cards left in policy deck

					observer.trigger('government:chaos');

				}
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
