<pet-game>
	<h1>Digipet <span class={ playing:inPlay }>GAME</span></h1>

	<img src="images/{ petImage }.png" style="background-image:url(images/{ backgroundImg });" ref="pet">

	<div>
		<div class="bar health">
			<div style="width:{ percentHealth }%;">&nbsp;</div>
		</div>
		<p>HEALTH: { petHealth }</p>
	</div>

	<div>
		<div class="bar strength">
			<div style="width:{ percentStrength }%;">&nbsp;</div>
		</div>
		<p>STRENGTH: { petStrength }</p>
	</div>

	<button onclick={ feed } disabled={ petHealth <= 0 || !inPlay }>FEED PET</button>
	<button onclick={ exercise } disabled={ petHealth <= 0 || !inPlay }>EXERCISE PET</button>
	<button onclick={ reset } show={ petHealth <= 0 || !inPlay }>RESET</button>

	<info-console logs={ userLogs }></info-console>

	<script>
		var that = this;

		const TOTALHEALTH = 100;
		const WINHEALTH = TOTALHEALTH * 1.2;
		const CATSTRENGTH = 3;

		this.inPlay = true;

		this.petHealth = 80;
		this.petStrength = 0;

		this.percentHealth = this.petHealth;
		this.percentStrength = this.petStrength;

		this.petImage = "pet-0";
		this.backgroundImg = "";

		this.userLogs = [];

		reset(event) {
			this.petHealth = 80;
			this.petStrength = 0;
			this.backgroundImg = "";
			this.userLogs = [];
			this.inPlay = true;
		}

		feed(event) {
			this.petHealth = this.petHealth + 10;
			this.addToLog('Your pet eats and gains health.');
		}

		exercise(event) {
			this.petStrength = this.petStrength + 1;
			this.petHealth = this.petHealth - 10;
			this.addToLog('Your pet works out and gains strength.');
		}

		addToLog(msg) {
			this.userLogs.push(msg);
		}

		catAttacks() {
			var randDecimal = Math.random();
			return randDecimal < 0.5 ? true : false;
		}

		catCombat() {
			if (this.petStrength > CATSTRENGTH) {
				this.addToLog('Ooo, sexy biceps. Cats are afraid of your pet.');
				this.updatePetImage('strong');
			} else {
				this.petStrength = this.petStrength - 1;
				this.petHealth = this.petHealth - 25;
				this.addToLog('Mean cat steals your food and beats you up.');
				this.updatePetImage('weak');
			}
		}

		updatePetImage(imageType) {
			var imgMap = {
				"win": "pet-win",
				"strong": "pet-strong",
				"weak": "pet-weak",
				"exercise": "pet-workout"
			};

			if (imgMap[imageType] && this.petHealth > 0) {
				this.petImage = imgMap[imageType];
			} else {
				if (this.petHealth > (TOTALHEALTH * 0.8)) {
					this.petImage = "pet-0";
				} else if (this.petHealth > (TOTALHEALTH * 0.6)) {
					this.petImage = "pet-1";
				} else if (this.petHealth > (TOTALHEALTH * 0.4)) {
					this.petImage = "pet-2";
				} else if (this.petHealth > (TOTALHEALTH * 0.2)) {
					this.petImage = "pet-3";
				} else if (this.petHealth > 0) {
					this.petImage = "pet-4";
				} else {
					this.petImage = "pet-5"; // DEAD
				}
			}
		}

		setStatBars(event) {
			if (this.petHealth < 0) {
				this.percentHealth = 0;
			} else if (this.petHealth > 100) {
				this.percentHealth = 100;
			} else {
				this.percentHealth = this.petHealth;
			}

			if (this.petStrength < 0) {
				this.percentStrength = 0;
			} else if (this.petStrength > CATSTRENGTH) {
				this.percentStrength = 100;
			} else {
				this.percentStrength = this.petStrength / CATSTRENGTH * 100;
			}
		}

		resolveOutcomes(event) {
			if (this.inPlay) {
				if (this.petHealth >= WINHEALTH) {
					this.updatePetImage('win');
					this.backgroundImg = "confetti.gif";
					this.addToLog('You WIN! Cats don\'t bother you anymore.');
					this.inPlay = false;
				} else if (this.catAttacks()) {
					this.catCombat();
				} else {
					this.updatePetImage();
				}
			} else {
				this.updatePetImage();
			}

			this.setStatBars();
		}

		this.on('update', function() {

			this.resolveOutcomes();

			if (this.petHealth <= 0) {
				this.inPlay = false;
			}

		});

	</script>

	<style>
		:scope {
			display: block;
			font-family: Helvetica;
			text-align: center;
		}
		h1 {
			padding-bottom: 1em;
			border-bottom: 1px solid #DDD;
		}
		button {
			font-size: 1.5em;
			padding: 0.5em;
			border-radius: 0.25em;
			background-color: coral;
			border: 1px solid navy;
			cursor: pointer;
		}
		.bar {
			width: 100%;
			border: 1px solid grey;
			text-align: left;
		}
		.bar > div {
			transition: width 1s;
		}
		.bar.health > div {
			background-color: dodgerblue;
		}
		.bar.strength > div {
			background-color: gold;
		}
		h1 > span {
			background-color: tomato;
			padding: 0.5em;
			border-radius: 0.25em;
		}
		.playing {
			background-color: yellowgreen;
		}
	</style>
</pet-game>
