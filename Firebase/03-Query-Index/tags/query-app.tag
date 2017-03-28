<query-app>
	<h1 class="page-header">QUERY / INDEX</h1>
	<h2>Part I</h2>
	<p>Basic Query examples: take a look at the following actions that use different query methods. The key parts to understand are:</p>
	<ul>
		<li>orderByChild()</li>
		<li>limitToFirst()</li>
		<li>equalTo()</li>
	</ul>
	<form class="form-inline">
		<button class="btn btn-success" type="button" onclick={ getAllStudents }>getAllStudents( )</button>
		<button class="btn btn-default" type="button" onclick={ versionA }>versionA( )</button>
		<button class="btn btn-default" type="button" onclick={ versionB }>versionB( )</button>
		<button class="btn btn-default" type="button" onclick={ versionC }>versionC( )</button>
	</form>

	<br>
	<h2>Part II</h2>
	<p>Note that currently, this section isn't fully working... we're going to fix it.</p>

	<form class="form-inline">
		<div class="form-group">
			<select class="form-control" onchange={ setGenderFilter }>
				<option value="all" checked>GENDER</option>
				<option value="male">MALE</option>
				<option value="female">FEMALE</option>
				<option value="n/a">OTHER</option>
			</select>
		</div>
		<div class="form-group">
			<button class="btn btn-primary" type="button" onclick={ getStudents }>GET Students</button>
		</div>
	</form>

	<br>
	<h2>OUTPUT</h2>
	<pre><strong>ITEM COUNT</strong> = { Object.keys(data).length }<br><strong>DATA</strong> = { json }</pre>

	<br>
	<h2>Part III</h2>
	<form class="form-inline">
		<input class="form-control" type="text" ref="traitInput" placeholder="Enter trait" onkeypress={ updateTraits }>
		<button class="btn btn-primary" type="button" onclick={ updateTraits }>SEARCH</button>
	</form>

	<br>
	<pre><strong>TRAITS</strong> = { traits }</pre>

	<script>
		var that = this;
		this.gender = "all";
		this.traits = {};

		// Cached firebase refs for convenience
		var database = firebase.database();
		var studentsRef = database.ref('students');
		var charsRef = studentsRef.child('characteristics');
		var traitsRef = database.ref('traits');

		// STARTER nonsense data
		this.data = {a:1,b:2,c:3};
		this.json = toJSON(this.data);
		this.traits = toJSON(this.traits);

		console.log('query-app.tag');


		/*
			https://firebase.google.com/docs/reference/js/firebase.database.Query

			0) IMPORT the data-A.json file to your database.
			1) Analyze getAllStudents() to understand how we're getting data and outputting to the <pre>.
			2) Compare versionA(), versionB(), and versionC(). What does orderByChild(), limitToFirst(), and equalTo() do? Play with the values by replacing gender with other key properties of a student as well as the number limit - note how many data objects of interest exist in the full data set.
			3) Try to get the PART II functionality to work, you'll have to work with the existing UI as well as add something to the UI to complete this task.
			4) What's the difference between the students reference and traits reference (see database) in terms of the KEYS used?
			5) How does the data structure of using traits as keys, help me in terms of finding students with particular traits?
			6) In PART III, query "h" word fragments. Try: 'h', 'ha', 'han', etc. How does your result change? How does the function updateTraits() work?
			7) Can you get student data of all students who are "brave"?
			8) Make your own queries - here or on your own data.
		*/

		/*
			Part I --------------------------------------------------
		*/
		getAllStudents(event) {
			studentsRef.once('value', function(snapshot) {
				that.data = snapshot.val();
				that.update();
			});
		}
		versionA(event) {
			studentsRef.orderByChild('gender').once('value', function(snapshot){
				that.data = snapshot.val();
				that.update();
			});
		}
		versionB(event) {
			// Try changing the limit to 5, what happens?
			studentsRef.orderByChild('gender').limitToFirst(4).once('value', function(snapshot){
				that.data = snapshot.val();
				that.update();
			});
		}
		versionC(event) {
			studentsRef.orderByChild('gender').equalTo('n/a').once('value', function(snapshot){
				that.data = snapshot.val();
				that.update();
			});
		}



		/*
			Part II --------------------------------------------------
		*/
		getStudents(event) {
			event.preventUpdate = true;

			if (this.gender === "all") {
				studentsRef.once('value', function(snapshot){
					that.data = snapshot.val();
					that.update();
				});
			} else {
				// Can you hook this up so that we can get just the gender selected?
				// Can you create the interface AND hook it up so that users can enter a limit to how many get queried? E.g. 2, no more than 5.
			}
		}
		setGenderFilter(event) {
			this.gender = event.target.value;
		}

		/*
			Part III --------------------------------------------------
		*/

		updateTraits(event) {
			event.preventUpdate = true;

			if (event.type === "click" || event.type === "keypress" && event.which === 13) {
				var queryString = that.refs.traitInput.value;

				// HINT: Below, you see something like '\uf8ff'. This is a character code that represents a character with a very very very high value. E.g. B comes after A. X comes after B. '\uf8ff' comes WAAAAY after any reasonable character in terms of order.
				// Think of it like if I enter 'a' + '\uf8ff', it's almost like entering 'az'.
				// So what does it mean when I say, search traits between: 'ha' and 'haz'? What traits would come up?

				traitsRef.orderByKey().startAt(queryString).endAt(queryString + '\uf8ff').once('value', function(snapshot){
				  that.traits = snapshot.val();
					that.update();
				});

				event.preventDefault();
			}
		}


		/*
			HELPERS --------------------------------------------------
		*/

		// Converts javascript object data to JSON string
		function toJSON(jsData) {
			return JSON.stringify(jsData, null, 2);
		}
		// Converts data to JSON every update
		this.on('update', function(){
			that.json = toJSON(that.data);
			that.traits = toJSON(that.traits);
		});


	</script>

	<style>
		:scope {
			display: block;
		}
	</style>
</query-app>
