<app>
  <!-- HTML -->
	<h1>Hello { username }</h1>
	<h1>ROUND: { rounds }</h1>
	<p>Is it my turn? ... { myTurn ? "YES" : "NO" }</p>
	<button type="button" onclick={ toggleTurn }>Toggle Turn</button>
	<button type="button" onclick={ nextRound }>NEXT</button>
	<!-- <button type="button" onclick={ saveData }>SAVE</button> -->

	<input type="text" ref="username" value="">
	<button type="button" onclick={ createUser }>NEW USER</button>

	<button type="button" onclick={ getPaulosData }>Paulo Data</button>

  <script>
    // JAVASCRIPT
    let tag = this;
		this.db;
		this.myTurn;
		this.username = "";



		fetch('http://treasure.chrisproctor.net/players/' + 64526).then(response => {
			return response.json();
		}).then(data => {
			// Work with JSON data here
			this.username = data.name;
			console.log('64526', data);
			this.update();
		});

		createUser() {
			var username = this.refs.username.value;
			fetch('http://treasure.chrisproctor.net/players/new/' + username).then(response => {
			  return response.json();
			}).then(data => {
			  // Work with JSON data here
			  console.log(data);

			}).catch(err => {
			  // Do something for an error here
				alert('ERROR')
			});
		}

		if (localStorage.getItem('gameData')) {
			var json = localStorage.getItem('gameData');
			this.db = JSON.parse(json)
			this.rounds = this.db.games['a1'].rounds;
			this.myTurn = this.db.games['a1'].myTurn;
		} else {
			this.db = {
				users: {
					"abc123": {
						name: "Jin",
						age: 21
					},
					"def456": {
						name: "Jin",
						age: 21
					}
				},
				games: {
					"a1": {
						rounds: 4
					},
					"b7": {
						rounds: 10
					}
				}
			};
		}

		toggleTurn() {
			if (this.db.games['a1'].myTurn) {
				this.db.games['a1'].myTurn = false;
			} else {
				this.db.games['a1'].myTurn = true;
			}
			this.myTurn = this.db.games['a1'].myTurn;
			this.saveData();
		}

		nextRound() {
			this.db.games['a1'].rounds++;
			this.rounds = this.db.games['a1'].rounds;
			this.saveData();
		}

		saveData() {
			localStorage.setItem("gameData", JSON.stringify(this.db));
		}


		// http://treasure.chrisproctor.net/players/56112
		getPaulosData() {
			fetch('http://treasure.chrisproctor.net/players/56112').then(response => {
			  return response.json();
			}).then(data => {
			  // Work with JSON data here
			  console.log(data);
			}).catch(err => {
			  // Do something for an error here
				alert('ERROR')
			});
		}



  </script>

  <style>
    /* CSS */
    :scope {}
  </style>
</app>
