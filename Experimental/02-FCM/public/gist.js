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






{
	"eventType": "providers/google.firebase.database/eventTypes/ref.write",
	"timestamp": "2017-04-07T20:47:32.749Z",
	"auth": {
		"admin": false,
		"variable": {
			"name": "Jin Kuwata",
			"email_verified": true,
			"provider": "google",
			"email": "jmk2142@tc.columbia.edu",
			"user_id": "MpbQb5PEAEe93gzkMJ4jndsW1IF2",
			"token": {
				"name": "Jin Kuwata",
				"email_verified": true,
				"email": "jmk2142@tc.columbia.edu",
				"exp": 1491598864,
				"user_id": "MpbQb5PEAEe93gzkMJ4jndsW1IF2",
				"picture": "https://lh4.googleusercontent.com/-baOQQ3g0MS4/AAAAAAAAAAI/AAAAAAAAA6w/oYbyQnDCyLo/photo.jpg",
				"iat": 1491595264,
				"sub": "MpbQb5PEAEe93gzkMJ4jndsW1IF2",
				"aud": "todo-firebase-37f73",
				"auth_time": 1491511218,
				"iss": "https://securetoken.google.com/todo-firebase-37f73",
				"firebase": {
					"identities": {
						"google.com": ["113923628943675529952"],
						"email": ["jmk2142@tc.columbia.edu"]
					},
					"sign_in_provider": "google.com"
				}
			},
			"uid": "MpbQb5PEAEe93gzkMJ4jndsW1IF2",
			"picture": "https://lh4.googleusercontent.com/-baOQQ3g0MS4/AAAAAAAAAAI/AAAAAAAAA6w/oYbyQnDCyLo/photo.jpg"
		}
	},
	"data": {
		"author": "Jin Kuwata",
		"createdAt": 1491595998572,
		"id": "-Kh92AJqkkvPbW6qi7Qu",
		"message": "c",
		"modifiedAt": 1491598052749,
		"public": true,
		"userID": "MpbQb5PEAEe93gzkMJ4jndsW1IF2"
	},
	"params": {
		"commentID": "-Kh92AJqkkvPbW6qi7Qu"
	},
	"eventId": "kRHZnI9tss/B3XezE7Tzcg6RTKQ=",
	"resource": "projects/_/instances/todo-firebase-37f73/refs/comments/public/-Kh92AJqkkvPbW6qi7Qu"
}
