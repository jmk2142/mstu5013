<query-app>
	<h1 class="page-header">QUERY / INDEX</h1>
	<h2>Part I <small>Server-side Query</small></h2>

	<button type="button" onclick={ createAll }>CREATE ALL</button>
	<br><br>
	<!-- <input ref="username" placeholder="Enter name" onkeypress={ saveCandidate }> -->
	<select ref="hairColor" value="" onchange={ filterCandidates }>
		<option value="">HAIR</option>
		<option value="blonde">Blonde</option>
		<option value="brown">Brown</option>
		<option value="red">Red</option>
	</select>
	<select ref="heightStart" value="" onchange={ filterCandidates }>
		<option value="">HEIGHT START</option>
		<option value="5ft03in">5'3"</option>
		<option value="5ft09in">5'9"</option>
		<option value="6ft03in">6'3"</option>
	</select>
	<select ref="heightEnd" value="" onchange={ filterCandidates }>
		<option value="">HEIGHT END</option>
		<option value="5ft03in">5'3"</option>
		<option value="5ft09in">5'9"</option>
		<option value="6ft03in">6'3"</option>
	</select>
	<select ref="religion" value="" onchange={ filterCandidates }>
		<option value="">RELIGION</option>
		<option value="atheist">Atheist</option>
		<option value="agnostic">Agnostic</option>
		<option value="theist">Theist</option>
	</select>

	<br><br>

	<h2>Part II <small>Client-side Filter</small></h2>
	<select ref="clientHair" value="" onchange={ clientFilter }>
		<option value="">HAIR</option>
		<option value="blonde">Blonde</option>
		<option value="brown">Brown</option>
		<option value="red">Red</option>
	</select>
	<select ref="clientHeight" value="" onchange={ clientFilter }>
		<option value="">HEIGHT</option>
		<option value="5ft03in">5'3"</option>
		<option value="5ft09in">5'9"</option>
		<option value="6ft03in">6'3"</option>
	</select>
	<select ref="clientReligion" value="" onchange={ clientFilter }>
		<option value="">RELIGION</option>
		<option value="atheist">Atheist</option>
		<option value="agnostic">Agnostic</option>
		<option value="theist">Theist</option>
	</select>

	<br><br>
	<!-- <button type="button" onclick={ search }>SEARCH</button> -->

	<br>
	<h2>OUTPUT</h2>
	<pre><strong>COUNT</strong> = { candidates.length }<br><strong>candidates</strong> = { JSON.stringify(candidates, null, 2) }</pre>

	<script>
		var that = this;

		// Cached firebase refs for convenience
		var database = firebase.database();
		var candidatesRef = database.ref('candidate');
		var categoriesRef = database.ref('categories');

		var names = ["Alpha", "Bravo", "Charlie", "Echo", "Delta", "Foxtrot", "Golf", "Hotel", "Igloo", "Juliet", "Kilo", "Lima", "Mike", "November", "Oscar", "Papa", "Quebec", "Romeo", "Sierra", "Tango", "Uniform", "Victor", "Whiskey", "Xray", "Apple", "Apricot", "Avocado", "Banana", "Bilberry", "Blackberry", "Blackcurrant", "Blueberry", "Boysenberry", "Currant", "Cherry", "Cherimoya", "Cloudberry", "Coconut", "Cranberry", "Cucumber", "CustardApple", "Damson", "Date", "Dragonfruit", "Durian", "Elderberry", "Feijoa", "Fig", "GojiBerry", "Gooseberry", "Grape", "Raisin", "Grapefruit", "Guava", "Honeyberry", "Huckleberry", "Jabuticaba", "Jackfruit", "Jambul", "Jujube", "JuniperBerry", "Kiwifruit", "Kumquat", "Lemon", "Lime", "Loquat", "Longan", "Lychee", "Mango", "Marionberry", "Melon", "Cantaloupe", "Honeydew", "Watermelon", "Miraclefruit", "Mulberry", "Nectarine", "Nance", "Olive", "Orange", "BloodOrange", "Clementine", "Mandarine", "Tangerine", "Papaya", "Passionfruit", "Peach", "Pear", "Persimmon", "Physalis", "Plantain", "Plum", "Prune", "Pineapple", "Plumcot", "Pomegranate", "Pomelo", "PurpleMangosteen", "Quince", "Raspberry", "Salmonberry", "Rambutan", "Redcurrant", "SalalBerry", "Salak", "Satsuma", "Soursop", "StarFruit", "SolanumQuitoense", "Strawberry", "Tamarillo", "Tamarind", "UgliFruit", "Yuzu"];

		var hairColors = ["blonde","brown","red"];
		var heights = ["5ft03in","5ft09in","6ft03in"];
		var religions = ["atheist","agnostic","theist"];

		this.candidates = [];

		candidatesRef.once('value', function(snap){
		  that.candidates = _.chain(snap.val()).values().value();
			that.update();
		});

		filterCandidates(event) {
			var hair = this.refs.hairColor.value || "all";
			var heightStart = this.refs.heightStart.value || "all";
			var heightEnd = this.refs.heightEnd.value || "all";
			var religion = this.refs.religion.value || "all";

			// categoriesRef.child(`${hair}_${height}_${religion}`).once('value', function(snap){
			// 	that.candidates = _.chain(snap.val()).values().value();
			// 	that.update();
			// });

			categoriesRef.orderByKey().startAt(`${hair}_${heightStart}_${religion}`).endAt(`${hair}_${heightEnd}_${religion}`).once('value', function(snap){
				var data = [];
				snap.forEach(function(childSnap){
					childSnap.forEach(function(dataSnap) {
						data.push(dataSnap.val());
					});
				});
				that.candidates = _.uniq(data, function(item, key, list) {
				  return item.username;
				});
				that.update();
			});
		}

		/*
			'Where' Object with properties/values to index:
			{
				hair: 'blonde',
				height: '5ft3in',
				religion: 'agnostic'
			}
			Whole thing works better if all categories are filled even with 'n/a' or '' empty string values.
		*/
		function indexWhere(where, data) {
			var keys = _.chain(where).values().map(function(cat){
			  return cat ? cat : "null";
			}).value();
			return indexKeys = combination(keys);
		}

		function combination(arr) {
		  let i, j, temp
		  let result = []
		  let arrLen = arr.length
		  let power = Math.pow
		  let combinations = power(2, arrLen)

		  // Time & Space Complexity O (n * 2^n)
		  for (i = 0; i < combinations;  i++) {
		    temp = ''

		    for (j = 0; j < arrLen; j++) {
		      // & is bitwise AND
		      if ((i & power(2, j))) {
		        temp += arr[j]
		      } else {
						temp += "all"
					}
					if (j < arrLen-1) {
						temp+='_'
					}
		    }
		    result.push(temp)
		  }
		  return result
		}

		function indexCandidate(candidate) {
			var key = candidatesRef.push().key;
			var where = {
				hair: candidate.hair,
				height: candidate.height,
				religion: candidate.religion
			};

			var updates = {};
			updates[`candidate/${key}`] = candidate;

			_.each(indexWhere(where), function(cat){
			  updates[`categories/${cat}/${key}`] = candidate;
			});

			database.ref().update(updates);
		}

		clientFilter(event) {
		  candidatesRef.limitToFirst(1000).once('value', function(snap) {
				var people = _.map(snap.val(), function(item, key, list) {
					item.id = key;
				  return item;
				});

				var hair = that.refs.clientHair.value;
				var height = that.refs.clientHeight.value;
				var religion = that.refs.clientReligion.value;

				var where = {};

				if (hair) { where.hair = hair; }
				if (height) { where.height = height; }
				if (religion) { where.religion = religion; }

				that.candidates = _.where(people, where);
				that.update();
		  });
		}

		createAll() {
			_.each(names, function(name){
				var candidate = {
					username: name,
					hair: _.sample(hairColors, 1)[0],
					height: _.sample(heights, 1)[0],
					religion: _.sample(religions, 1)[0]
				};
				indexCandidate(candidate);
			});
		}

		saveCandidate(event) {
			if (event.type === "keypress" && event.which === 13) {
				var candidate = randomCreate();
						candidate.username = this.refs.username.value;
						candidateRef.push(candidate);
				this.refs.username.value = "";
				this.refs.username.focus();
			}
		}


	</script>

	<style>
		:scope {
			display: block;
		}
	</style>
</query-app>
