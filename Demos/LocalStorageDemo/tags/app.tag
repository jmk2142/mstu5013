<app>
  <!-- HTML -->
	<h1>{ username ? "Welcome back" : "Hello"} { username || "Anonymous" }</h1>

	<div class="card">
		<div class="card-header bg-primary text-light">
			Bits and Atoms EXAMPLE
		</div>
		<div class="card-body">
			<div class="row">
				<div class="col">
					<div class="form-group">
						<input type="text" ref="pid" class="form-control" placeholder="Enter PID" value="42251">
					</div>
					<div class="form-group">
						<button class="btn btn-dark" onclick={ getPlayer }>Find Player</button>
					</div>
					<div class="form-group">
						<input type="text" ref="username" class="form-control" placeholder="Enter USERNAME">
					</div>
					<div class="form-group">
						<button class="btn btn-success" onclick={ createPlayer }>New Player</button>
					</div>
				</div>
				<div class="col">
					<p>USERNAME: { username }</p>
					<p>UID: { userID }</p>
					<p><strong>API RESPONSE:</strong></p>
					<pre>{ json }</pre>
				</div>
			</div>
		</div>
	</div>

	<div class="card">
		<div class="card-header bg-primary text-light">
			LocalStorage (LS) EXAMPLE
		</div>
		<div class="card-body">
			<div class="row">
				<div class="col">
					<div class="form-group">
						<label>
							Happiness:
							<input class="form-control" ref="happyEl" type="range" min="0" max="100" value={ happiness } oninput={ changeHappy }>
						</label>
					</div>
					<div class="form-group">
						<label>
							Favorite Food:
							<select class="form-control" ref="foodEl" onchange={ changeFood } value={ food }>
								<option value="" selected disabled>Select</option>
								<option value="hotdog">Hotdogs</option>
								<option value="hamburger">Hamburgers</option>
								<option value="salad">Salad</option>
							</select>
						</label>
					</div>
					<div class="form-group" ref="codeEl" onclick={ changeCode }>
						<div>
							Likes Code:
						</div>
						<div class="form-check form-check-inline">
							<input class="form-check-input" type="radio" name="likeCode" id="likeCodeYES" value="likes" checked={ code === "likes" }>
							<label class="form-check-label" for="likeCodeYES">YES</label>
						</div>
						<div class="form-check form-check-inline">
							<input class="form-check-input" type="radio" name="likeCode" id="likeCodeNO" value="dislikes" checked={ code === "dislikes" }>
							<label class="form-check-label" for="likeCodeNO">NO</label>
						</div>
					</div>
					<div class="form-group">
						<label>
							Favorite Color:
							<input class="form-control" ref="colorEl" type="color" onchange={ changeColor } value={ color }>
						</label>
					</div>
				</div>
				<div class="col">
					<p class="{alert:username, alert-success:username}"><strong>Current User:</strong> { username || "Anonymous" }</p>
					<p><strong>Happiness:</strong> { happiness }</p>
					<p><strong>Fav Food:</strong> { food }</p>
					<p><strong>Likes Code:</strong> { code }</p>
					<p><strong>Fav Color:</strong> <span class="badge" style="background-color:{ color }">{ color }</span></p>

					<p><strong>LocalStorage:</strong></p>
					<pre>"dataLS": { localJSON }</pre>
				</div>
			</div>
		</div>
		<div class="card-footer">
			<button class="btn btn-warning" onclick={ log }><code>console.log(localStorage)</code></button>
			<button class="btn btn-success" onclick={ save }>SAVE to LS</button>
			<button class="btn btn-danger" onclick={ reset }>RESET LS</button>
		</div>
	</div>

  <script>
    // JAVASCRIPT
    let tag = this;

		// LIFECYCLE EVENT LISTENER
		this.on('before-mount', () => {
			this.getLocalData('dataLS');
		});

		/******************************
		BITS AND ATOMS DATA EXAMPLES
		******************************/

		// BITS AND ATOMS + Tag Instance
		this.username = "";
		this.userID = "";
		this.json = "";

		getPlayer() {
			let pid = this.refs.pid.value;

			fetch('http://treasure.chrisproctor.net/players/' + pid).then(response => {
				return response.json();
			}).then(playerData => {
				this.username = playerData.name;
				this.userID = playerData.pid;
				this.refs.pid.value = "";
				this.updateJSON(playerData);
				this.update();
			}).catch(error => {
				alert('Error');
			});
		}

		createPlayer() {
			let username = this.refs.username.value;

			fetch('http://treasure.chrisproctor.net/players/new/' + username).then(response => {
				return response.json();
			}).then(playerData => {
				this.username = playerData.name;
				this.userID = playerData.pid;
				this.refs.username.value = "";
				this.updateJSON(playerData);
				this.update();
			}).catch(error => {
				alert('Error');
			});
		}

		updateJSON(data) {
			this.json = JSON.stringify(data, null, 2);
		}


		/******************************
		LOCALSTORAGE DATA EXAMPLES
		******************************/

		// LOCALSTORAGE + Tag Instance
		this.localJSON = "";

		// GENERAL INTERFACE
		log() {
			console.log(localStorage);
		}
		save() {
			let data = {
				happiness: parseInt(this.refs.happyEl.value, 10),
				food: this.refs.foodEl.value || undefined,
				code: (() => {
					if (this.refs.codeEl.querySelector(':checked')) {
						return this.refs.codeEl.querySelector(':checked').value;
					} else {
						return undefined;
					}
				})(),
				color: this.refs.colorEl.value
			};
			this.setLocalData(data);
			this.updateLocalJSON();
		}
		reset() {
			localStorage.clear();
			this.updateLocalJSON();
		}

		// PLAYER/USER CONFIG INTERFACE
		changeHappy(event) {
			let happiness = event.target.value;
			this.happiness = happiness;
		}
		changeFood(event) {
			let favFood = event.target.value;
			this.food = favFood;
		}
		changeCode(event) {
			if (event.target.type === "radio") {
				this.code = event.target.value;
			}
		}
		changeColor(event) {
			let hex = event.target.value; // #AA33B1 etc.
			this.color = hex;
		}

		// LOCAL STORAGE METHODS
		getLocalData(key) {
			let json = localStorage.getItem(key);
			let data;
			if (json) {
				data = JSON.parse(json);
				for (prop in data) {
					this[prop] = data[prop];
				}
			}
			this.updateLocalJSON();
		}
		setLocalData(data) {
			let json = JSON.stringify(data);
			localStorage.setItem("dataLS", json);
		}
		updateLocalJSON() {
			let data = JSON.parse(localStorage.getItem('dataLS'));
			this.localJSON = JSON.stringify(data, null, 2);
		}

  </script>

  <style>
    /* CSS */
    :scope {}
		.card {
			margin-bottom: 3em;
		}
		pre {
			background-color: #F5F5F5;
			padding: 1em;
			border-radius: 0.25em;
		}
  </style>
</app>
