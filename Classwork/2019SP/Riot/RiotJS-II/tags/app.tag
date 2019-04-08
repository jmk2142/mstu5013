<app>
  <!-- HTML -->
	<div class="container">
		<div class="row">
			<div class="col">
				<h1>INPUTS AND EVENTS</h1>
			</div>
		</div>
		<div class="row">
			<!-- LEFT -->
			<div class="col">
				<div class="card">
					<div class="card-header">
						CONTROLS
					</div>
					<div class="card-body">
						<div class="form-group">
							<p>CUSTOMER:</p>
							<input class="form-control" type="text" ref="fullName" placeholder={ fullName || "Enter full name."} value={ fullName } oninput={ updateName }>
						</div>
						<div class="form-group">
							<p>SERVINGS:</p>
							<button class="btn btn-dark" type="button" onclick={ increment }>INCREMENT</button>
							<button class="btn btn-dark" type="button" onclick={ decrement }>DECREMENT</button>
						</div>
						<div class="form-group">
							<p>Choose MAIN:</p>
							<select class="form-control" onchange={ updateBreakfast }>
								<option value="" selected disabled>Enter Breakfast Choice</option>
								<option value="pancakes">Pancakes</option>
								<option value="waffles">Waffles</option>
								<option value="country">Country Breakfast</option>
							</select>
						</div>
						<div class="form-group" ref="sides" onclick={ updateSides }>
							<p>Choose SIDES:</p>
							<div class="form-check form-check-inline">
								<input id="sideA" class="form-check-input" type="checkbox" value="sausage">
								<label class="form-check-label" for="sideA">Sausage</label>
							</div>
							<div class="form-check form-check-inline">
								<input id="sideB" class="form-check-input" type="checkbox" value="bacon">
								<label class="form-check-label" for="sideB">Bacon</label>
							</div>
							<div class="form-check form-check-inline">
								<input id="sideC" class="form-check-input" type="checkbox" value="english" checked>
								<label class="form-check-label" for="sideC">English Muffin</label>
							</div>
						</div>
						<div class="form-group" ref="drink" onclick={ updateDrink }>
							<p>Choose Drink:</p>
							<div class="form-check form-check-inline">
								<input class="form-check-input" type="radio" name="drink" id="drinkA" value="coffee" checked>
								<label class="form-check-label" for="drinkA">Coffee</label>
							</div>
							<div class="form-check form-check-inline">
								<input class="form-check-input" type="radio" name="drink" id="drinkB" value="tea">
								<label class="form-check-label" for="drinkB">Tea</label>
							</div>
						</div>
						<div class="form-group">
							<p>Reservation TIME:</p>
							<input class="form-control" type="time" min="07:00" max="11:30" step="1800" value={ order.time } onchange={ updateTime }>
						</div>
					</div>
					<div class="card-footer">
						<button class="btn btn-{ orderReady ? 'success' : 'danger' }" type="button" onclick={ submitOrder } disabled={ !orderReady }>ORDER</button>
					</div>
				</div>
			</div>

			<!-- RIGHT -->
			<div class="col">
				<div class="card">
					<div class="card-header">
						<span class="badge badge-primary">app.tag</span>
					</div>
					<div class="card-body">
						<pre>app.tag = <code ref="json"></code></pre>
					</div>
					<div class="card-footer"></div>
				</div>
			</div>
		</div>

		<receipt if={ orderReady && submitted } breakfast={ order }></receipt>
	</div>



  <script>
    // JAVASCRIPT
    let tag = this;

		this.orderReady = false;
		this.submitted = false;
		this.order = {
			servings: 1,
			time: "07:30"
		};

		increment() {
			this.order.servings++;
		}
		decrement() {
			if (this.order.servings > 1) {
				this.order.servings--;
			}
		}

		updateName(event) {
			this.order.fullName = event.target.value;
		}
		updateBreakfast(event) {
			this.order.mainDish = event.target.value;
		}
		updateSides(event) {
			let checkedEls = [...this.refs.sides.querySelectorAll(':checked')];
			this.order.sides = checkedEls.map( el => el.value);
		}
		updateDrink(event) {
			let checkedRadioEl = this.refs.drink.querySelector(':checked');
			this.order.drink = checkedRadioEl.value;
		}
		updateTime(event) {
			this.order.time = event.target.value;
		}

		updateReady() {
			this.orderReady = (this.order.hasOwnProperty('fullName') && this.order.hasOwnProperty('mainDish') && this.order.hasOwnProperty('sides') && this.order.hasOwnProperty('drink') && this.order.hasOwnProperty('time'));
		}
		submitOrder() {
			if (this.orderReady) {
				this.submitted = true;
			}
		}




		// This function listens for any Riot UPDATE event and fires the routines.
		this.on('update', () => {
			this.updateReady();
			this.refs.json.textContent = JSON.stringify(this, null, 2);
		});

  </script>

  <style>
    /* CSS */
    :scope {}
		.card {
			margin-bottom: 2em;
		}
  </style>
</app>
