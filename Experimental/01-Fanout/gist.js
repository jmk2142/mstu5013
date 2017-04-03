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
	Problem with setting up an index like:
	blonde_5ft00in_any is if your data changes shape.
	Right now, we're producing this key pattern by propery alpha order.
		hair, height, family -> blonde_5ft00in_any
	But if we add gender -> we'd either have to add it to the end which would then take more managing when we build indices, or change the existing key, every.

	We know that MOST people are going to be searching by a particular gender. Might be good to organize it like:

		by_gender
			male
				userIDs
				...
			female
				userIDs
				...
			all
				...

	Another way we could deal with this is to provide a searchable index IN the user object itself based on some of the criteria we want.

	{
		username: "Romeo",
		hair: "brown",
		height: "5ft09in",
		family: "Montague",
		by_hairHeightFamily: "brown_5ft09in_family" // .indexOn
	}

	In this way, we could search by .orderByChild('by_hairHeightFamily') ... even search ranges like everything .startAt('brown_5ft09in').endAt('brown_06ft00in') which should get all people in that height range.

	If we add a new property like salary, we would need to append this index with another "column" brown_5ft09in_family_050k although we don't really have a way of saying range of height AND range of salary.
	This won't work: .startAt('brown_05ft06in_capulet_045k').endAt('brown_05ft10in_montague_065k')
	as it will also include 'brown_05ft09in_capulet_075k' as all capulets come before montague alphabetically.

	Also, problematic is if we don't care about family. Do we look up _capulet_ or _montague_ ? Should we then have an _all_ category? But then you can't do all this in a single index string.
*/

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
