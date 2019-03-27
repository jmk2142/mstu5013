<game-board>
  <!-- HTML -->
	<h1>GAME-BOARD.tag</h1>
	<div class="card">
		<div class="card-header">
			GAME STAGE PROGRESSION TEST
		</div>
		<div class="card-body">
			<p><span class="badge badge-dark">PLAYERS: { players.length }</span> <span class="badge badge-info">ROUND: { round }</span></p>
			<h3 show={currentStage === "election:president"}>New president is assigned.</h3>
			<h3 show={currentStage === "election:chancellor"}>President nominates Chancellor.</h3>
			<h3 show={currentStage === "election:public"}>Public votes on government.</h3>
			<h3 show={currentStage === "legislative:president"}>President draws 3, discards policy.</h3>
			<h3 show={currentStage === "legislative:chancellor"}>Chancellor discards 1 policy.</h3>
			<h3 show={currentStage === "executive:president"}>
				<span show={ executivePower.power }>President { executivePower.used ? "already used" : "must use"} EXECUTIVE POWER</span>
				<span show={ !executivePower.power }>No executive powers this round...</span>
				<small show={ executivePower.power }>{ executivePower.power }</small>
			</h3>
		</div>
		<div class="card-footer">
			<button class="btn btn-secondary" type="button" onclick={ advanceStage }>ADVANCE</button>
			<button show={ currentStage === "executive:president" && executivePower.power } class="btn btn-secondary" type="button" onclick={ usePower } disabled={ executivePower.used }>USE POWER</button>
		</div>
	</div>

	<div class="card">
		<div class="card-header">
			GAME STATE TEST
		</div>
		<div class="card-body">
			<h3 show={ policiesFascist.length > 3 }><span class="badge badge-danger">DANGER</span> Game ends if Hitler becomes Chancellor</h3>
			<h3 show={ policiesFascist.length > 4 }><span class="badge badge-warning">WARNING</span> VETO power unlocked</h3>
			<h3 show={ policiesFascist.length === 6 }><span class="badge badge-dark">WIN</span> FASCISTS WIN</h3>
			<h3 show={ policiesLiberal.length === 5 }><span class="badge badge-success">WIN</span> LIBERALS WIN</h3>
			<hr show={ policiesFascist.length > 3 }>
			<div class="row">
				<div class="col">
					<h3>FASCIST POLICIES: { policiesFascist.length}</h3>
					<div class="card-test" each={ policy, i in policiesFascist }>
						<img src="./assets/game/card-policy-{ policy }.jpg">
						<div class="overlay overlay-{policy}"></div>
					</div>
					<p show={ !policiesFascist.length }>NO CARDS</p>
				</div>
				<div class="col">
					<h3>LIBERAL POLICIES: { policiesLiberal.length}</h3>
					<div class="card-test" each={ policy, i in policiesLiberal }>
						<img src="./assets/game/card-policy-{ policy }.jpg">
						<div class="overlay overlay-{policy}"></div>
					</div>
					<p show={ !policiesLiberal.length }>NO CARDS</p>
				</div>
			</div>
		</div>
		<div class="card-footer"></div>
	</div>

	<div class="card">
		<div class="card-header">CARDS TEST</div>
		<div class="card-body">
			<span>DRAW PILE: <span class="badge badge-{primary:policyDrawDeck.length, warning:!policyDrawDeck.length}">{ policyDrawDeck.length }</span></span>
			<span>DISCARD PILE: <span class="badge badge-{primary:policyDiscardDeck.length, warning:!policyDiscardDeck.length}">{ policyDiscardDeck.length }</span></span>
			<span>HAND PILE: <span class="badge badge-{primary:policyHandDeck.length, warning:!policyHandDeck.length}">{ policyHandDeck.length }</span></span>

			<hr>

			<div class="row">
				<div class="col">
					<h5>HAND DECK <small>click to discard</small></h5>
					<div class="card-test" each={ policy, i in policyHandDeck } onclick={ discard }>
						<img src="./assets/game/card-policy-{ policy }.jpg">
						<div class="overlay overlay-{policy}"></div>
					</div>
					<p show={ !policyHandDeck.length }>NO CARDS</p>
				</div>
				<div class="col">
					<h5>DRAW DECK</h5>
					<div class="card-test" each={ policy, i in policyDrawDeck }>
						<img src="./assets/game/card-policy-{ policy }.jpg">
						<div class="overlay overlay-{policy}"></div>
					</div>
					<p show={ !policyDrawDeck.length }>NO CARDS</p>
				</div>
				<div class="col">
					<h5>DISCARD DECK</h5>
					<div class="card-test" each={ policy, i in policyDiscardDeck }>
						<img src="./assets/game/card-policy-{ policy }.jpg">
						<div class="overlay overlay-{policy}"></div>
					</div>
					<p show={ !policyDiscardDeck.length }>NO CARDS</p>
				</div>
			</div>

		</div>
		<div class="card-footer">
			<button class="btn btn-success" type="button" onclick={ draw } disabled={policyHandDeck.length > 0}>DRAW</button>
		</div>
	</div>

	<div class="card">
		<div class="card-header">MISCELLANEOUS</div>
		<div class="card-body">
			<pre>game-board.tag: <code ref="tagJSON" class="language-json">{ tagObjectJSON }</code></pre>
			<strong>miscellaneousCount:</strong> <span class="badge badge-primary">{ miscellaneousCount }</span>
		</div>
		<div class="card-footer">
			<button class="btn btn-secondary" type="button" onclick={ print }>PRINT THIS</button>
			<button class="btn btn-secondary" type="button" onclick={ incrementCount }>COUNT++</button>
			<button class="btn btn-secondary" type="button" onclick={ decrementCount }>COUNT--</button>
			<button class="btn btn-secondary" type="button" onclick={ update }>UPDATE TAG</button>
		</div>
	</div>


  <script>
    // JAVASCRIPT
    let tag = this;
		let shuffle = opts.gameData.shuffle;

		// PLAYER SETUP
		this.players = opts.gameData.players;
		this.playerCount = this.players.length;

		// GAME SETUP: Rounds and Stages (of rounds)
		this.round = 0;
		this.currentStage = "election:president";

		this.stages = ["election","legislative","executive"];
		this.mechanics = {
			election: ["president", "chancellor", "public"],
			legislative: ["president", "chancellor"],
			executive: ["president"]
		};
		this.stageIndex = 0;
		this.mechanicIndex = 0;

		// EXECUTIVE SETUP: based on playerCount
		this.executiveActions = (function() {
			if (this.playerCount < 7) {
				return [
					{power: "", used:false},
					{power: "", used:false},
					{power: "policyPeek", used:false},
					{power: "execution", used:false},
					{power: "execution", used:false},
				];
			} else if (this.playerCount < 9) {
				return [
					{power: "", used:false},
					{power: "loyalty", used:false},
					{power: "specialElection", used:false},
					{power: "execution", used:false},
					{power: "execution", used:false}
				];
			} else {
				return [
					{power:"loyalty", used:false},
					{power:"loyalty", used:false},
					{power:"specialElection", used:false},
					{power:"execution", used:false},
					{power:"execution", used:false}
				];
			}
		}.bind(this))();
		this.executivePower = {power:"", used:false};


		// POLICY SETUP: 11 fascist policies, 6 liberal policies
		this.policyDiscardDeck = [];
		this.policyDrawDeck = shuffle([
			"fascist","fascist","fascist","fascist","fascist","fascist","fascist","fascist","fascist","fascist","fascist",
			"liberal","liberal","liberal","liberal","liberal","liberal"
		]);
		this.policyHandDeck = [];
		this.policiesFascist = [];
		this.policiesLiberal = [];
		this.vetoPower = false;


		// START ROUND
		advanceStage() {
			let stage = this.stages[this.stageIndex];
			let mechanics = this.mechanics[stage];
			let mechanic;

			if (this.mechanicIndex < mechanics.length - 1) {
				this.mechanicIndex++;
			} else {
				this.mechanicIndex = 0;
				if (this.stageIndex < this.stages.length - 1) {
					this.stageIndex++;
				} else {
					this.round++;
					this.stageIndex = 0;
				}
			}

			stage = this.stages[this.stageIndex];
			mechanic = mechanics[this.mechanicIndex];

			this.currentStage = stage + ":" + mechanic;

			// SET EXECUTIVE POWER
			if (this.currentStage === "executive:president" && this.policiesFascist.length > 0) {
				this.executivePower = this.executiveActions[this.policiesFascist.length - 1];
				if (!this.executivePower.used) {
					console.log("PRESIDENT MUST USE THIS POWER:" + this.executivePower.power);
				} else {
					console.log("NO New Power to be used...");
				}
			}
		}

		usePower(event) {
			this.executivePower.used = true;
		}

		// President DRAWS 3
		draw(event) {
			this.policyHandDeck = this.policyDrawDeck.splice(0, 3);
		}

		// President Discards 1
		// Chancellor Discards 1
		discard(event) {
			let index = event.item.i;
			let discardedPolicy = this.policyHandDeck.splice(index, 1);
			this.policyDiscardDeck = [...this.policyDiscardDeck, ...discardedPolicy];
			if (this.policyHandDeck.length === 1) {
				if (this.policyHandDeck[0] === "fascist") {
					this.policiesFascist = [...this.policiesFascist, ...this.policyHandDeck.splice(0)];
				} else {
					this.policiesLiberal = [...this.policiesLiberal, ...this.policyHandDeck.splice(0)];
				}

				// Remake, Reshuffle Draw Deck
				if (this.policyDrawDeck.length < 3) {
					this.policyDrawDeck = shuffle([...this.policyDrawDeck, ...this.policyDiscardDeck.splice(0)]);
				}
			}
		}


		/********************
		MISCELLANEOUS
		********************/
		this.tagObjectJSON = "JSON";
		print(event) {
			event.preventUpdate = true;
			this.tagObjectJSON = JSON.stringify(this, null, 2);
			this.update();
			Prism.highlightElement(this.refs.tagJSON);
		}

		this.miscellaneousCount = 0;
		incrementCount(event) {
			event.preventUpdate = true;
			this.miscellaneousCount++;
		}
		decrementCount(event) {
			this.miscellaneousCount--;
		}

		/********************
		Observer Listeners
		********************/
		observer.on('government:chaos', () => {
			let policy = this.policyDrawDeck.splice(0, 1)[0];
			if (policy === "fascist") {
				// What now?
			} else {
				// What now?
			}
		});

  </script>

  <style>
    /* CSS */
    :scope {}
    .special {
      background-color: #333333;
      color: #FFFFFF;
    }
		.card {
			margin-bottom: 1em;
		}
		.card-test {
			position: relative;
			display: inline-block;
			width: 50px;
			margin-right: 0.25em;
		}
		.card-test img {
			width: 100%;
		}
		.card-test .overlay {
			position: absolute;
			top: 0; bottom: 0; left: 0; right: 0;
		}
		.overlay-fascist {
			background-color: #dc3545;
			opacity: 0.25;
		}
		.overlay-liberal {
			background-color: #007bff;
			opacity: 0.25;
		}
  </style>
</game-board>
