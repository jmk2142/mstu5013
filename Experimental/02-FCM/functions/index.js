const functions = require('firebase-functions');
const admin = require('firebase-admin');
admin.initializeApp(functions.config().firebase);

const _ = require('lodash');

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

		console.log('LODASH:', _.VERSION);
		console.log('ADDED BY:', event.auth.variable.name, 'UID:', event.auth.variable.uid);

		const comment = event.data.val();
		const upper = comment.author.toUpperCase();
		return event.data.ref.child('author').set(upper);

	});



const mkdirp = require('mkdirp-promise');
const gcs = require('@google-cloud/storage')();
const spawn = require('child-process-promise').spawn;
const LOCAL_TMP_FOLDER = '/tmp/';

const THUMB_MAX_HEIGHT = 200;
const THUMB_MAX_WIDTH = 200;
const THUMB_PREFIX = 'thumb_';

exports.makeThumbs = functions.storage.object()
	.onChange(event => {
		const filePath = event.data.name;
		const filePathSplit = filePath.split('/');
		const fileName = filePathSplit.pop();
		const fileDir = filePathSplit.join('/') + (filePathSplit.length > 0 ? '/' : '');
		const thumbFilePath = `${fileDir}${THUMB_PREFIX}${fileName}`;
		const tempLocalDir = `${LOCAL_TMP_FOLDER}${fileDir}`;
		const tempLocalFile = `${tempLocalDir}${fileName}`;
		const tempLocalThumbFile = `${LOCAL_TMP_FOLDER}${thumbFilePath}`;

		if (!event.data.contentType.startsWith('image/')) {
			console.log('This is not an image.');
			return;
		}
		if (fileName.startsWith(THUMB_PREFIX)) {
			console.log('This is a deletion event.');
			return;
		}

		return mkdirp(tempLocalDir).then(() => {
			const bucket = gcs.bucket(event.data.bucket);
			return bucket.file(filePath).download({
				destination: tempLocalFile
			}).then(() => {
				console.log('The file has been downloaded to', tempLocalFile);

				return spawn('convert', [tempLocalFile, '-thumbnail', `${THUMB_MAX_WIDTH}x${THUMB_MAX_HEIGHT}>`, tempLocalThumbFile]).then(() => {
					console.log('Thumbnail created at', tempLocalThumbFile);

					return bucket.upload(tempLocalThumbFile, {
						destination: thumbFilePath
					}).then(() => {
						console.log('Thumbnail uploaded to Storage at', thumbFilePath);
					});

				});
			});
		});

	});
