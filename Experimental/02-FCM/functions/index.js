const functions = require('firebase-functions');
const admin = require('firebase-admin');
admin.initializeApp(functions.config().firebase);

// // Start writing Firebase Functions
// // https://firebase.google.com/functions/write-firebase-functions
//
// exports.helloWorld = functions.https.onRequest((request, response) => {
//  response.send("Hello from Firebase!");
// }).

exports.test = functions.database.ref('/comments/public/{commentID}')
	.onWrite(event => {

		// Only edit data when it is first created
		if (event.data.previous.exists()) {
			return;
		}

		// Delete
		if (!event.data.exists()) {
			return;
		}

		console.log('ADDED BY:', event.auth.variable.name, 'UID:', event.auth.variable.uid);

		const comment = event.data.val();
		const upper = comment.author.toUpperCase();
		return event.data.ref.child('author').set(upper);

	});
