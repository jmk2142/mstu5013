// Setup the game
var TOTALHEALTH = 100;
var WINHEALTH = TOTALHEALTH * 1.2;



var petHealth = 85;
var petStrength = 0;

var catStrength = 5;

var turnCount = 0;


// Pet Image Selector
function updatePetImage(imageType) {
	var imageSrc = "images/pet-0.png";

	if (imageType === "win") {
		imageSrc = "images/pet-win.png";
	} else if (imageType === "strong") {
		imageSrc = "images/pet-strong.png";
	} else if (imageType === "weak") {
		imageSrc = "images/pet-weak.png";
	} else if (imageType === "exercise") {
		imageSrc = "images/pet-workout.png";
	} else { // Regular images

		if (petHealth > (TOTALHEALTH * 0.8)) {
			imageSrc = "images/pet-0.png";
		} else if (petHealth > (TOTALHEALTH * 0.6)) {
			imageSrc = "images/pet-1.png";
		} else if (petHealth > (TOTALHEALTH * 0.4)) {
			imageSrc = "images/pet-2.png";
		} else if (petHealth > (TOTALHEALTH * 0.2)) {
			imageSrc = "images/pet-3.png";
		} else if (petHealth > 0) {
			imageSrc = "images/pet-4.png";
		} else {
			imageSrc = "images/pet-5.png"; // DEAD
		}

	}

	$('img').attr('src', imageSrc);
}

function updateScores() {
	$('#health').html(petHealth);
	$('#strength').html(petStrength);

	if (petHealth < 1) {
		updatePetImage();
		outputLog('Your pet is no more. You LOSE.\n');
	} else if (petHealth > WINHEALTH) {
		updatePetImage('win');
		outputLog('Congratulations. Your pet is muscles, like Arnold Schwarzenegger. You WIN.\n');
	}
}

function catAttacks() {
	var attack;

	var randDecimal = Math.random(); // Math.random() produces a random number between 0 and 0.99999
	var roundedInt = Math.round(randDecimal); // Math.round() will take 0.5 and greater and round it to 1, less than 0.5 and round to zero.

	if (roundedInt === 0) {
		attack = true;
	} else {
		attack = false;
	}

	return attack;
}

function catCombat() {
	if (petStrength > catStrength) {
		outputLog('Ooo, sexy biceps. Cats are afraid of your pet.\n');
		updatePetImage('strong');
	} else {
		outputLog('Mean cat steals your food and beats you up.\n');
		petStrength = petStrength - 1;
		petHealth = petHealth - 25;
		updatePetImage('weak');
	}
}

function oneUpTurn() {
	turnCount = turnCount + 1;
}

function outputLog(message) {
	$('pre').prepend('TURN ' + turnCount + ': ' + message);
}


$('#feed').click(function(event) {
	// Increment petHealth
	petHealth = petHealth + 10;

	// Cause random cat attack
	if (catAttacks()) {
		catCombat();
	} else {
		updatePetImage();
		outputLog('Your pet eats and gains health.\n');
	}

	// Update scores
	updateScores();

	oneUpTurn();
});

$('#exercise').click(function(event) {
	// Increment petStrength
	petStrength = petStrength + 1;
	petHealth = petHealth - 10;

	// Update pet image
	updatePetImage('exercise');

	// Update log
	outputLog('Your pet works out (eye of the tiger).\n');

	// Update scores
	updateScores();

	oneUpTurn();
});

$('#reset').click(function(event) {
	alert('What code should go here?');
});
