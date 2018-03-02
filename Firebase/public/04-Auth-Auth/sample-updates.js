/root
	/groupA
		/messageID
	/groupB
		/messageID

var message = {msg:"I love cats."};
var database = firebase.database();

// If I wanted to write to two places.
// Setting in GroupA and GroupB

var key = database.ref('groupA').push().key;
	database.ref('groupA/' + key).set(message);
	database.ref('groupB/' + key).set(message);

// If I wanted to write in two places at ONCE.
// Updating in GroupA and GroupB

var key = database.ref('groupA').push().key;
var updates = {};
	updates['groupA/' + key] = message;
	updates['groupB/' + key] = message;
	database.ref().update(updates);

// Above, update will `set` in two places at once.
// If one fails, nothing will be written.
// All or nothing. Atomic. This helps with consistency.

// The updates object basically looks something like this:
{
	"groupA/-Kv35k3j42lk3": message,
	"groupB/-Kv35k3j42lk3": message
}
// It's just an object where the properties are the ref locations,
// the value is what you want to set at that location.

// You can even delete in one location and write to another
// simultatneously.
var updatedMessage = {msg:"I don't like cats."}
var updates = {};
	updates['groupA/' + key] = updatedMessage; // key from above
	updates['groupB/' + key] = null;
	database.ref().update(updates);


/root
	/things

// If I did the following, what would you expect to see
// in the DB? (Brain teaser problem.)
var myRef = firebase.database().ref('things');
var data = {name:"penguin"};
var locations = {};
	locations['animals'] = data;
	locations['plants'] = data;
	locations['plants'] = "Coconuts";
	locations['minerals'] = {gem:"Pearl", updated:true};
myRef.update(locations);
var blah = {};
	blah['animals/name'] = "kiwi";
	blah['minerals/updated'] = false;
myRef.update(blah);
