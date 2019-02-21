<game>
	<div class="container-fluid">
		<div class="row">

			<!-- SIDEBAR: START -->
			<div id="side" class="col-3 min-vh-100">
				<img id="titleImg" src="./assets/1200px-Secret_Hitler.png">

				<!-- INTRO -->
				<div show={ menuState === "intro"} class="text-center">
					<p><strong>{ yearsSince } years</strong> since the end of fascism. Maybe.</p>
					<button class="btn btn-light" onclick={ startNewGame }>New Game</button>
				</div>

				<!-- GAME TYPE -->
				<div show={ menuState === "gameType" } class="text-center">
					<p>Choose a game type:</p>
					<button class="btn btn-light" onclick={ startHotseat }>Hotseat</button>
					<button class="btn btn-light" onclick={ startOnline } disabled>Online</button>
				</div>

				<!-- PLAYER COUNT -->
				<div show={ menuState === "playerCount" }>
					<div class="form-group">
						<p>How many players?</p>
						<select class="form-control" onchange={ setNumPlayers }>
							<option value="" disabled selected>Select Player Count</option>
							<option value="5">5 Players</option>
							<option value="6">6 Players</option>
							<option value="7">7 Players</option>
							<option value="8">8 Players</option>
							<option value="9">9 Players</option>
							<option value="10">10 Players</option>
						</select>
					</div>
					<div class="card">
						<div class="card-header">
							Your game will have:
						</div>
					  <div class="card-body">
							<div class="row text-center">
								<div class="col">
									<img class="preview-role-card" src="./assets/game/card-role-liberal.jpg">
									<p><span class="role-count">{ playerTypes.liberal || "?" }</span><br>Liberals</p>
								</div>
								<div class="col">
									<img class="preview-role-card" src="./assets/game/card-role-fascist.jpg">
									<p><span class="role-count">{ playerTypes.fascist || "?" }</span><br>Facists</p>
								</div>
								<div class="col">
									<img class="preview-role-card" src="./assets/game/card-role-hitler.jpg">
									<p><span class="role-count">{ playerTypes.hitler || "?" }</span><br>Hitler</p>
								</div>
							</div>
					  </div>
						<div class="card-footer">
							<button class="btn btn-success float-right" onclick={ customizeUsers }>CONFIRM</button>
						</div>
					</div>
				</div>

				<!-- PLAYER CUSTOMIZE -->
				<div if={ menuState === "playerCustomize" }>
					<div class="card">
						<div class="card-header">
							Give each player a name.
						</div>
						<div class="card-body">

							<div class="form-group" each={ user, i in players }>
								<input class="form-control" placeholder="Player {i+1} Name" oninput={ parent.setName } value={ user.name || "" }>
							</div>
							<p class="text-right">
								<span class="float-left">{ playersReady ? "Ready" : "Waiting..."}</span>
								<span class="badge { badge-dark:!playersReady, badge-success:playersReady } align-text-bottom">{ readyCount }/{ playerCount }</span>
							</p>
						</div>
						<div class="card-footer">
							<button class="btn btn-light" onclick={ autoFill }>AUTO-FILL</button>
							<button class="btn btn-success float-right" disabled={ !playersReady } onclick={ revealIdentities }>NEXT</button>
						</div>
					</div>
				</div>

				<!-- GOVERNMENT STATUS -->
				<government if={ playing }></government>

				<!-- Panel for Player Stats and Actions -->
				<players-panel if={ playing } players={ players }></players-panel>

				<!-- Commands Available Always -->
				<div class="form-group text-center mt-3" hide={ menuState === "intro" } >
					<button class="btn btn-light" onclick={ resetGame }>RESET</button>
				</div>


			<!-- SIDEBAR: END -->
			</div>


			<!-- MAIN CONTENT: START -->
			<div id="main" class="col-9">

				<!-- REVEAL TAG -->
				<reveal if={ menuState == "partyReveal" && !playing } players={ players }></reveal>

				<!-- GAME BOARDS -->
				<game-board if={ playing } game-data={ gameData }></game-board>

			<!-- MAIN CONTENT: END -->
			</div>
		</div>
	</div>

  <script>
    // JAVASCRIPT
		let tag = this;

		const endWWII = new Date('September 02, 1945');
		const today = new Date();

		this.yearsSince = today.getYear() - endWWII.getYear();

		this.menuState = "intro";	// intro, gameType, playerCount, playerCustomize

		this.playing = false;
		this.online = false;
		this.players = [];
		this.playerCount = 5;
		this.playerTypes = { liberal: 0, fascist: 0, hitler: 0 };
		this.playersReady = false;
		this.readyCount = 0;

		/********************
		TAG INSTANCE METHODS
		********************/

		startNewGame(event) {
			this.menuState = "gameType";
		}

		startHotseat(event) {
			this.online = false;
			this.menuState = "playerCount";
		}

		setNumPlayers(event) {
			this.playerCount = Number(event.target.value);
			this.playerTypes = getPlayerTypes(this.playerCount);
			this.players = createPlayers(this.playerCount);
		}

		function createPlayers(playerCount) {
			let players = [];
			for (let i=0; i < playerCount; i++) {
				players.push({
					name: "",
					party: "",
					president: false,
					chancellor: false,
					hitler: false,
					ready: false,
					termLimited: false
				});
			}
			return players;
		}

		resetGame(event) {
			this.menuState = "intro";
		}

		setName(event) {
			event.item.user.name = event.target.value.trim();
			this.updateReadyCount();
			this.playersReady = !(this.readyCount < this.playerCount);
		}

		revealIdentities(event) {
			this.assignPlayerRoles();
			this.menuState = "partyReveal";
		}

		assignPlayerRoles() {
			let roles = [];
			for (key in this.playerTypes) {
				let count = this.playerTypes[key];
				for (let i=0; i < count; i++) {
					roles.push(key);
				}
			}

			shuffle(roles); // ["liberal","hitler","fascist","liberal","liberal"]

			for (let i=0; i < this.players.length; i++) {
				if (roles[i] === "hitler") {
					this.players[i].hitler = true;
					this.players[i].party = "fascist";
				} else {
					this.players[i].party = roles[i];
				}
			}
		}

		updateReadyCount() {
			this.readyCount = this.players.filter(player => player.name).length;
		}

		customizeUsers(event) {
			this.menuState = "playerCustomize";
		}

		playGame() {
			this.playing = true;
			this.gameData = {
				players: this.players,
				shuffle: shuffle
			};
			this.update();
		}

		/********************
		HELPER FUNCTIONS
		********************/

		// This function is solely for filling in Player Names while testing to decrease time spent typing.
		autoFill(event) {
			const autoNames = ["Aardvark","Bronco","Chipmunk","Dragon","Elephant","Fox","Giraffe","Horse","Iguana","Jackal"];
						shuffle(autoNames);
			let inputs = [...this.root.querySelectorAll('input')];
			inputs.map((el, i) => {
				el.value = autoNames[i];
				tag.players[i].name = autoNames[i];
			});
			this.updateReadyCount();
			this.playersReady = !(this.readyCount < this.playerCount);
		}

		// This function takes number of players and returns the correct distribution of roles based on game size.
		function getPlayerTypes(numPlayers) {
			let playerTypes;

			switch (numPlayers) {
				case 6: playerTypes = { liberal: 4, fascist: 1, hitler: 1 }; break;
				case 7: playerTypes = { liberal: 4, fascist: 2, hitler: 1 }; break;
				case 8: playerTypes = { liberal: 5, fascist: 2, hitler: 1 }; break;
				case 9: playerTypes = { liberal: 5, fascist: 3, hitler: 1 }; break;
				case 10: playerTypes = { liberal: 6, fascist: 3, hitler: 1 }; break;
				default: playerTypes = { liberal: 3, fascist: 1, hitler: 1 };
			}

			return playerTypes;
		}

		/**
		 * Shuffles array in place.
		 * @param {Array} a items An array containing the items.
		 * https://stackoverflow.com/questions/6274339/how-can-i-shuffle-an-array
		 */
		function shuffle(list) {
	    var j, x, i;
	    for (i = list.length - 1; i > 0; i--) {
	        j = Math.floor(Math.random() * (i + 1));
	        x = list[i];
	        list[i] = list[j];
	        list[j] = x;
	    }
	    return list;
		}

		/********************
		DEVELOPER PUSH --- Code to push state of game to where I want to test.
		Comment OUT to start from beginning
		********************/
		(function() {
			// console.log('game.tag', this);

			let playerCount = 5;
			this.playerTypes = getPlayerTypes(playerCount);
			this.players = createPlayers(playerCount);

			const autoNames = ["Aardvark","Bronco","Chipmunk","Dragon","Elephant","Fox","Giraffe","Horse","Iguana","Jackal"];
			for (let i=0; i < this.players.length; i++) {
				this.players[i].name = autoNames[i];
			}
			this.playersReady = true;
			this.assignPlayerRoles();
			this.playGame();
		}.bind(this))();

  </script>

  <style>
    /* CSS */

		#side {
			background-color: #ff593f;
		}
		#main {
			background-color: #ffaa8b;
		}
		#titleImg {
			width: 100%;
			margin: 1em 0;
			padding: 1em;
		}

		.preview-role-card {
			border: 1px solid silver;
			border-radius: 0.25em;
			width: 100%;
			padding: 0.5em;
		}
		.role-count {
			font-weight: bold;
			font-size: 2em;
		}
  </style>
</game>
