<app>

	<button onclick={ makeEasier }>EASIER</button>
	<button onclick={ makeHarder }>HARDER</button>

	<question each={ questionItem in questions } num-ref={ numRefSet } box-size={ boxSize }></question>

	<script>
		var that = this;

		// These would be customized each time they "clear" a level and move toward an easier or more difficult set.
		this.minSize = 1;
		this.maxSize = 2.25;
		this.boxSize = 2;

		var numLow = 0;
		var numHigh = 9;

		// Number reference set
		// See the js/scaleSteps.js file for helper functions
		// makeSet can take two numbers and create a range.
		// E.g. 1, 3 would make a range from 1 to 3 (easy)
		// E.g. 0, 100 - maybe more difficult.
		this.numRefSet = makeSet(numLow, numHigh, this.minSize, this.maxSize);

		var difficultySteps = 3;
		var difficultyStep = (this.maxSize - this.minSize) / difficultySteps;

		this.difficulty = 0;

		// makeEasier(event) {
		// 	if (this.difficulty !== 0) {
		// 		this.maxSize = this.maxSize + difficultyStep;
		// 		this.difficulty--;
		// 		this.numRefSet = makeSet(numLow, numHigh, this.minSize, this.maxSize);
		// 	} else {
		// 		alert(`Difficulty is at MIN - Level ${ this.difficulty }`);
		// 	}
		// 	console.log(this)
		// }
		makeHarder(event) {
			if (this.difficulty < difficultySteps) {
				this.maxSize = this.maxSize - difficultyStep;
				this.difficulty++;
				this.numRefSet = makeSet(numLow, numHigh, this.minSize, this.maxSize);
				console.log(this.numRefSet);
			} else {
				alert(`Difficulty is at MAX - Level ${ this.difficulty }`);
			}
			console.log(this)
		}
		this.on('update', function() {
			console.log('app updated');
		})

		// Current questions are hard coded so you really can't make interesting differnt sets right now. But if the options were dynamically generated based on the makeSet()... Current question design wouldn't allow it though.
		this.questions = [{
			id: "a",
			question: "What is the largest number?",
			options: [9,1],
			correct: 4
		}];

		// this.questions = [{
		// 	id: "a",
		// 	question: "What is the largest number?",
		// 	options: [9,1,8,1,5],
		// 	correct: 4
		// },{
		// 	id: "b",
		// 	question: "What is the smallest number?",
		// 	options: [5,6,7,8],
		// 	correct: 5
		// },{
		// 	id: "c",
		// 	question: "What is the largest prime number?",
		// 	options: [2,3,5,7],
		// 	correct: 7
		// },{
		// 	id: "d",
		// 	question: "What is the smallest prime number?",
		// 	options: [2,9,5,1],
		// 	correct: 2
		// },{
		// 	id: "e",
		// 	question: "Which is the lucky number?",
		// 	options: [0,1,2,3,4,5,6,7,8,9],
		// 	correct: 7
		// },{
		// 	id: "f",
		// 	question: "Who ate nine?",
		// 	options: [9,7,5,3,1,0,2,4,6,8],
		// 	correct: 7
		// }];

	</script>

	<style>
		:scope {
			display: block;
		}
		button {
			font-size: 2em;
			margin-bottom: 1em;
		}
	</style>
</app>
