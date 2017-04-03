/* ------------------------------
	Complex / AND Queries

	Firebase (not)allowed-key-characters
	http://stackoverflow.com/questions/41142571/firebase-push-key-allowed-characters
------------------------------ */
var datingData = [{
		username: "Romeo",

		// Ex: We want to search on these characteristics only
		hair: "brown",
		height: "5ft09in",
		family: "Montague"
	},
	{
		username: "Juliet",

		// Ex: Find me people with blonde && 5ft04in && ANYFamily
		hair: "blonde",
		height: "5ft04in",
		family: "Capulet"
	}
];

// ["a","b"] -> ["ab","_b","a_","__"]
function combination(list) {
	let i, j, temp;
	let result = [];
	let power = Math.pow;
	let length = list.length;
	let combinations = power(2, length);
	let spacer = "_";

	// Time & Space Complexity O (n * 2^n)
	for (i = 0; i < combinations; i++) {
		temp = "";
		for (j = 0; j < length; j++) {
			// & is bitwise AND
			if ((i & power(2, j))) {
				temp += list[j];
			} else {
				temp += "any";
			}
			// Append spacer
			if (j < length - 1) {
				temp += spacer;
			}
		}
		result.push(temp);
	}
	return result;
}

/*
	Move and Copy - Firebase
	https://gist.github.com/katowulf/6099042
*/
function copyFbRecord(oldRef, newRef) {
	oldRef.once('value', function(snap) {
		newRef.set(snap.value(), function(error) {
			if (error && typeof(console) !== 'undefined' && console.error) {
				console.error(error);
			}
		});
	});
}

function moveFbRecord(oldRef, newRef) {
	oldRef.once('value', function(snap) {
		newRef.set(snap.value(), function(error) {
			if (!error) {
				oldRef.remove();
			} else if (typeof(console) !== 'undefined' && console.error) {
				console.error(error);
			}
		});
	});
}
