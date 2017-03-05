<app>
	<h1>APP TAG</h1>
	<button type="button" onclick={ toggleStateA }>Button A</button>
	<input type="text" value="" placeholder="Text B" onchange={ updateStateB } ref="textB">
	<div>
		<textarea rows="4" placeholder="Textarea C" onkeyup={ updateStateC }></textarea>
	</div>
	<div>
		<label>
			English
			<input type="radio" name="language" value="eng" onclick={ updateStateD } checked>
		</label>
		<label>
			Spanish
			<input type="radio" name="language" value="spa" onclick={ updateStateD }>
		</label>
		<label>
			Japanese
			<input type="radio" name="language" value="jpn" onclick={ updateStateD }>
		</label>
	</div>
	<div>
		<select onchange={ updateStateE }>
			<option value="">-----</option>
			<option value="car">Car</option>
			<option value="bicycle">Bicycle</option>
		</select>
	</div>
	<div>
		<label>
			Alpaca
			<input type="checkbox" value="alpaca" onchange={ updateStateFPets }>
		</label>
		<label>
			Cat
			<input type="checkbox" value="cat" onchange={ updateStateFPets }>
		</label>
		<label>
			Parrot
			<input type="checkbox" value="parrot" onchange={ updateStateFPets }>
		</label>
	</div>

<pre>
this.stateA = { stateA ? "truthy" : "falsy" };
this.stateB = { stateB };
this.stateC = { stateC || "no text" };
this.stateD = { stateD.toUpperCase() };
this.stateE = { stateE };
this.stateF = alpaca > { stateFPets.alpaca ? "yes" : "no"}
              cat    > { stateFPets.cat ? "yes" : "no"}
              parrot > { stateFPets.parrot ? "yes" : "no"}
</pre>

	<script>
		this.testX = function(event){
		  alert('changed');
		}

		console.log('THIS TAG', this);

		this.stateA = false;
		this.stateB = "default text";
		this.stateC = "";
		this.stateD = "eng";
		this.stateE = "none selected";

		this.stateFPets = {
			alpaca: false,
			cat: false,
			parrot: false
		};

		this.toggleStateA = function(event){
			this.stateA = !this.stateA;
		};

		this.updateStateB = function(event){
			console.log(event.target.value);
			this.stateB = this.refs.textB.value;
		};

		this.updateStateC = function(event){
		  this.stateC = event.target.value;
		};

		this.updateStateD = function(event){
			this.stateD = event.target.value;
		};

		this.updateStateE = function(event){
		  this.stateE = event.target.value;
		};

		this.updateStateFPets = function(event){
		  var petType = event.target.value;
			var isChecked = event.target.checked;
			this.stateFPets[petType] = isChecked;
		};

	</script>

	<style>
		:scope {
			font-family: Helvetica;
		}
		pre {
			border: 1px solid #333;
			padding: 10px;
			border-radius: 4px;
			background-color: #F5F5F5;
		}
	</style>
</app>
