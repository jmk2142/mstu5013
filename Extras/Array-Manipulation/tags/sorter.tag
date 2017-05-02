<sorter>

	<br>
	<h3>FILTERING</h3>
	<div class="row">
		<div class="col-md-4">
			<select class="form-control" ref="manipulation" onchange={ manipulateData }>
				<option value="" checked>Select</option>
				<option value="onlyFavorites">Only Favorites</option>
				<option value="onlyDarker">Only Darker</option>
				<option value="everyOther">Every Other</option>
			</select>
		</div>
	</div>
	<br>
	<img each={ shownColors } src={ url }>
	<br>
	<br>

	<h3>MAPPING</h3>
	<div class="row">
		<div class="col-md-4">
			<select class="form-control" ref="manipulation" onchange={ selectChallenge }>
				<option value="mapBasic">CHALLENGE: To Simple String Array</option>
				<option value="mapObject">CHALLENGE: To Object</option>
			</select>
		</div>
	</div>
	<br>
	<div class="row">
		<div class="col-md-4">
			<pre><strong>ORIGINAL</strong><br><br>{ JSON.stringify(colors, null, 2) }</pre>
		</div>
		<div class="col-md-4">
			<pre if={ mapDemo === "mapBasic" }><strong>END SHAPE GOAL</strong><br><br>{ JSON.stringify([ "alpha","bravo","charlie","..." ], null, 2) }</pre>
			<pre if={ mapDemo === "mapObject" }><strong>END SHAPE GOAL</strong><br><br>{ JSON.stringify({"alpha":{"url": "images/alpha.png","background": "FFF","textColor": "000","favorite": true},"bravo":{"url": "images/bravo.png","background": "EEE","textColor": "000","favorite": false},"charlie": {"url": "images/charlie.png","background": "DDD","textColor": "000","favorite": false}, "delta": "..."}, null, 2) }</pre>
		</div>
		<div class="col-md-4">
			<pre><strong>TRANSFORMED</strong><br><br>{ JSON.stringify(remap, null, 2) }</pre>
		</div>
	</div>



	<script>
		var that = this;
		this.colors = this.opts.colordata;
		this.shownColors = this.colors;
		this.remap = this.colors;

		this.mapDemo = "mapBasic";

		this.manipulateData = function(event) {
			var orderType = event.target.value;

			// Filters boxes where favorite is true
			if (orderType === 'onlyFavorites') {
				this.shownColors = this.colors.filter(function(color){
				  return (color.favorite === true) || (color.favorite === false); // Why does this return all colors?
				});
			}

			// Filter boxes that have white text only
			if (orderType === 'blackText') {
				// HINT: type ("000" > "666") in console
				// HINT: type ("FFF" > "000") in console
				// HINT: type ("AAA" > "666") in console
			}

			// Filter colors darker than Foxtrot
			if (orderType === 'onlyDarker') {

			}

			if (orderType === '') {

			}

			console.log(this.colors);
		};


		this.transformData = function(event) {
		  this.remap = this.colors; // Replace this with your
		};






		this.selectChallenge = function(event) {
		  this.mapDemo = event.target.value;
		};

		this.on('update', function(event){
		  this.colors = this.opts.colordata;
			this.transformData();
		});


	</script>

	<style>
		:scope {
			display: block;
		}
	</style>
</sorter>
