// These can be changed and represent size.
var minSize = 1;
var maxSize = 10;
// Any type of units, px, em, % should work
// Although that has implications on the min/max size
var units = "em"; 

function makeSet(min, max) {
	var numList = [];

	for (var n=min; n<=max; n++) {
		numList.push({ num: n });
	}

	var sizeStep = (maxSize - minSize) / (numList.length - 1);
	var increment = 0;

	for (item of numList) {
		item.size = minSize + increment;
		increment += sizeStep;
		console.log(item);
	}

	return numList;
}

function getSize(num, set) {
	var numItem = set.find(function(setItem) {
		return setItem.num === num;
	});
	return numItem ? numItem.size : undefined;
}

// ----- ABOVE code is the stuff to dynamically setup a size step/scaling gradient. Flexible that it can take any min and max number range and create a linear gradient. To adjust the gradient, change the minSize or maxSize. If they're the same - you get the same size across.

// ----- BELOW code just implements the above helper functions to show how it works. You should be able to integrate the above into Riot in various ways, that means the below code is NOT the Riot contextual way.

var mySet = makeSet(0,9);

var testHTML = "";

for (item of mySet) {
	testHTML += `<span style="font-size:${ item.size }${units}">${ item.num }</span>`;
}

document.body.innerHTML = testHTML;
