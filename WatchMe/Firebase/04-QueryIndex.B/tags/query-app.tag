<query-app>
	<h1 class="page-header">QUERY / INDEX</h1>
	<p>This is a demonstration "dating" app where candidates have basically a few properties: <em>id, username, gender, hair, height, religion</em>. You can get a copy of the demonstration data within this folder: <strong>people-dating-app.json</strong></p>
	<p>We're really only interested in querying based on the latter 3 properties.</p>

	<br><br>
	<p>I am looking for...</p>
	<select ref="gender" value="" onchange={ getResults }>
		<option value="">GENDER</option>
		<option value="female">Female</option>
		<option value="male">Male</option>
	</select>

	<br><br>
	<p>My preferences are...</p>
	<select ref="hair" value="" onchange={ filterResults }>
		<option value="">HAIR</option>
		<option value="blonde">Blonde</option>
		<option value="brown">Brown</option>
		<option value="red">Red</option>
	</select>
	<select ref="height" value="" onchange={ filterResults }>
		<option value="">HEIGHT</option>
		<option value="5ft03in">5'3"</option>
		<option value="5ft09in">5'9"</option>
		<option value="6ft03in">6'3"</option>
	</select>
	<select ref="religion" value="" onchange={ filterResults }>
		<option value="">RELIGION</option>
		<option value="atheist">Atheist</option>
		<option value="agnostic">Agnostic</option>
		<option value="theist">Theist</option>
	</select>

	<br><br>
	<h2>OUTPUT</h2>
	<pre><strong>TOTAL in DB</strong> = { total }<br><strong>COUNT</strong> = { candidates.length }<br><strong>candidates</strong> = { JSON.stringify(candidates, null, 2) }</pre>

	<script>
		var that = this;
		that.total = "";

		// Cached firebase refs for convenience
		var database = firebase.database();
		var candidatesRef = database.ref('candidates');

		this.candidates = [];

		candidatesRef.once('value', function(snap) {
			var data = snap.val(); // One data object with all child candidate objects
			that.total = Object.keys(data).length;

			var listOfUsers = [];
			for (var key in data) {
				listOfUsers.push(data[key]);
			}

			that.candidates = listOfUsers;
			that.update();
		});

		getResults(event) {
			console.log('getResults()');
			var gender = this.refs.gender.value; // ""

			var query = candidatesRef.orderByChild('gender');

			if (gender) {
				query = query.equalTo(gender);
			}

			query.once('value', function(snap) {
				var data = snap.val();
				var listOfUsers = [];
				for (var key in data) {
					listOfUsers.push(data[key]);
				}

				that.candidates = listOfUsers;
				that.update();
			});

		}

		filterResults(event) {
			console.log('filterResults()');

			var gender = this.refs.gender.value; // ""

			var query = candidatesRef.orderByChild('gender');

			if (gender) {
				query = query.equalTo(gender);
			}

			query.once('value', function(snap) {
				var data = snap.val();
				var listOfUsers = [];
				for (var key in data) {
					listOfUsers.push(data[key]);
				}

				var selectedHair = that.refs.hair.value;
				var selectedHeight = that.refs.height.value;
				var selectedReligion = that.refs.religion.value;

				var filteredList = listOfUsers.filter(function(user) {
					if (selectedHair === "") {
						return true;
					} else {
						return user.hair === selectedHair;
					}
				});

				console.log(filteredList);
			});
		}

	</script>

	<style>
		:scope {
			display: block;
		}
	</style>
</query-app>
