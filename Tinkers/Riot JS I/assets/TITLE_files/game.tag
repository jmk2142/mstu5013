<game>
	<div class="container-fluid min-vh-100">
		<div class="row min-vh-100">

			<!-- SIDEBAR: START -->
			<div id="side" class="col-3 min-vh-100">
				<img id="titleImg" src="./assets/1200px-Secret_Hitler.png">

				<!-- INTRO -->
				<div show={ menuState === "intro"} class="text-center">
					<p><strong>{ yearsSince } years</strong> since the end of fascism.<br>Maybe.</p>
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
							<button class="btn btn-light" onclick={ resetGame }>RESET</button>
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
								<input class="form-control" placeholder="Player {i+1} Name" oninput={ parent.setName }>
							</div>
							<p class="text-right">
								<span class="float-left">{ playersReady ? "Ready" : "Waiting..."}</span>
								<span class="badge { badge-dark:!playersReady, badge-success:playersReady } align-text-bottom">{ readyCount }/{ playerCount }</span>
							</p>
						</div>
						<div class="card-footer">
							<button class="btn btn-light" onclick={ resetGame }>RESET</button>
							<button class="btn btn-light" onclick={ autoFill }>AUTO-FILL</button>
							<button class="btn btn-success float-right" disabled={ !playersReady } onclick={ playGame }>NEXT</button>
						</div>
					</div>
				</div>

			<!-- SIDEBAR: END -->
			</div>


			<!-- MAIN CONTENT: START -->
			<div id="main" class="col-9">

				<!-- REVEAL TAG -->
				<reveal if={ menuState == "partyReveal" } players={ players }></reveal>

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

		this.online = false;
		this.players = [];
		this.playerCount = 5;
		this.playerTypes = { liberal: 0, fascist: 0, hitler: 0 };
		this.playersReady = false;
		this.readyCount = 0;

		// TEST CODE
		// startFAST() {
		// 	this.menuState = "playerCustomize";
		// 	this.playerCount = 10;
		// 	this.playerTypes = getPlayerTypes(this.playerCount);
		//
		// 	this.players = [];
		// 	let names = ["Alpha","Bravo","Charlie","Delta","Echo","Foxtrot","Golf","Hotel","Igloo","Juliet"];
		// 	for (let i=0; i < this.playerCount; i++) {
		// 		this.players.push({
		// 			name: names[i],
		// 			party: "",
		// 			president: false,
		// 			chancellor: false,
		// 			hitler: false
		// 		});
		// 	}
		// }
		// this.startFAST();

		setName(event) {
			event.item.user.name = event.target.value.trim();
			this.updateReadyCount();
			this.playersReady = !(this.readyCount < this.playerCount);
		}

		playGame(event) {
			this.assignPlayerRoles();
			// alert("GAME READY: Let's PLAY");
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

			let randIndex = Math.floor(Math.random() * this.players.length);
			this.players[randIndex].president = true;
		}


		startNewGame(event) {
			this.menuState = "gameType";
		}


		updateReadyCount() {
			this.readyCount = this.players.filter(player => player.name).length;
		}

		startHotseat(event) {
			this.online = false;
			this.menuState = "playerCount";
		}

		// Same as above, but we'll use above short-hand version going forward.
		// this.startOnline = function(event) {
		// 	this.online = true;
		//	this.menuState = "playerCount";
		// }

		setNumPlayers(event) {
			this.playerCount = Number(event.target.value);
			this.playerTypes = getPlayerTypes(this.playerCount);

			this.players = [];
			for (let i=0; i < this.playerCount; i++) {
				this.players.push({
					name: "",
					party: "",
					president: false,
					chancellor: false,
					hitler: false
				});
			}
		}

		customizeUsers(event) {
			this.menuState = "playerCustomize";
		}

		resetGame(event) {
			this.menuState = "intro";
		}

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

		// Creating a static function that returns playerType count object
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

		this.on('update', () => {
			// console.log(this);
		});

  </script>

  <style>
    /* CSS */
		:scope {
			display: block;
		}
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

		/*
			bg-orange: #ffb758
			box-red: #ff593f
			box-pink: #ffaa8b
			box-beige: #ffdfbc
			box-dark: #434243
		*/
  </style>
</game>

<!--
https://secrethitler.tartanllama.xyz/
-->
