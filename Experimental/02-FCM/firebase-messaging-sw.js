importScripts('https://www.gstatic.com/firebasejs/3.7.0/firebase-app.js');
importScripts('https://www.gstatic.com/firebasejs/3.7.0/firebase-messaging.js');

// Initialize Firebase
var config = {
	apiKey: "AIzaSyCqmOOB2wbcKBxMbo-Vhsdmg1Lcl51CYLA",
	authDomain: "todo-firebase-37f73.firebaseapp.com",
	databaseURL: "https://todo-firebase-37f73.firebaseio.com",
	storageBucket: "todo-firebase-37f73.appspot.com",
	messagingSenderId: "308321612464"
};
firebase.initializeApp(config);

const messaging = firebase.messaging();
