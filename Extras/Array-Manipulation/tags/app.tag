<app>
	<div class="page-header">
		<h1>COLORS <small class="pull-right"><a href="#underscore">Jump to Underscore Challenges</a></small></h1>
	</div>


	<!-- ORIGINAL -->
	<h3>ORIGINAL</h3>
	<div>
		<img each={ colors } src={ url }>
	</div>

	<br><br>

	<!-- FILTER EXAMPLE -->
	<h3>FILTER</h3>
	<div>
		<img each={ filtered } src={ url }>
	</div>

	<br><br>

	<!-- MAP EXAMPLE -->
	<h3>MAP &mdash; See <a href="http://placehold.it">http://placehold.it</a></h3>
	<div each={ mapped }>
		<img src="http://placehold.it/{ width }x{ length }/{ backgroundHEX }/{ colorHEX }?text={ message }">
	</div>

	<br><br>

	<!-- DATA EXAMPLES -->
	<h3>DATA</h3>
	<div class="row">
		<div class="col-sm-4">
			<pre><strong>FILTERED</strong><br><hr><br>{ JSON.stringify(filtered, null, 2) }</pre>
		</div>
		<div class="col-sm-4">
			<pre class="originalPre"><strong>ORIGINAL RECIPE</strong><br><hr><br>{ JSON.stringify(colors, null, 2) }</pre>
		</div>
		<div class="col-sm-4">
			<pre><strong>MAPPED</strong><br><hr><br>{ JSON.stringify(mapped, null, 2) }</pre>
		</div>
	</div>

	<br><br>

	<!-- MY TEST DATA WITH UNDERSCORE -->
	<!-- <h3 id="underscore">UNDERSCORE CHALLENGES</h3>
	<div class="row">
		<div class="col-sm-6">
			<pre><strong>ORIGINAL RECIPE</strong><br><strong>LENGTH: </strong>{ colors.length }<hr><br>{ JSON.stringify(colors, null, 2) }</pre>
		</div>
		<div class="col-sm-6">
			<pre><strong>UNDERSCORE CHALLENGES</strong><br><strong>LENGTH: </strong>{ _.isArray(underscoreData) ? underscoreData.length : underscoreData }<hr><br>{ JSON.stringify(underscoreData, null, 2) }</pre>
		</div>
	</div> -->



	<!-- IMPLEMENTATION CHALLENGE -->
	<!-- <sorter colors={ colors }></sorter> -->


	<script>
		var that = this;

		this.colors = [{
			url: "images/alpha.png",
			background: "FFF",
			textColor: "000",
			favorite: true,
			pixels: 50,
			id: 28
		},{
			url: "images/bravo.png",
			background: "EEE",
			textColor: "000",
			favorite: false,
			pixels: 50,
			id: 14
		},{
			url: "images/charlie.png",
			background: "DDD",
			textColor: "000",
			favorite: false,
			pixels: 50,
			id: 42
		},
			// MADE compact so to make the relevant code easier to see:
			{ url: "images/delta.png",   background: "CCC", textColor: "000", favorite: true,  pixels: 50, id: 77 },
			{ url: "images/echo.png",    background: "BBB", textColor: "000", favorite: false, pixels: 50, id: 93 },
			{ url: "images/foxtrot.png", background: "AAA", textColor: "000", favorite: true,  pixels: 50, id: 84 },
			{ url: "images/golf.png",    background: "666", textColor: "FFF", favorite: true,  pixels: 50, id: 63 },
			{ url: "images/hotel.png",   background: "555", textColor: "FFF", favorite: false, pixels: 50, id: 14 },
			{ url: "images/igloo.png",   background: "444", textColor: "FFF", favorite: true,  pixels: 50, id: 56 },
			{ url: "images/juliet.png",  background: "333", textColor: "FFF", favorite: false, pixels: 50, id: 70 },
			{ url: "images/kilo.png",    background: "222", textColor: "FFF", favorite: false, pixels: 50, id: 21 },
			{ url: "images/lima.png",    background: "111", textColor: "FFF", favorite: false, pixels: 50, id: 49 },
			{ url: "images/mike.png",    background: "000", textColor: "FFF", favorite: true,  pixels: 50, id: 301 }
		];

		/* --------------------------------------------------------------------------------

			PATTERN:

			Array._____(function(element, index, list) {
				// You have access to the array element, its index, and the original array list.
				return someThing;
			});

			Predicate -> Special name but just a function that acts as a truth test by returning true or false.

				Array.filter(predicateFunction);

			Iteratee -> Special name but just a function that acts on each element in a set of data, a list.

				Array.map(iterateeFunction);

		-------------------------------------------------------------------------------- */


		// PREDICATE Function: basically a function that acts as a truth test.
		// Predicates always return true or false, and do something based on that evaluation
		// Can you filter every other color starting with the second?
		this.filtered = this.colors.filter(function(color, i, list) {
		  return color.favorite === true;
		});

		// ITERATEE Function: basically a function that does onto each thing.
		// Iterators are functions that apply themselves to each element in the array?
		// Explain how we "remapped" the original data to this new form
		// What would this.mapped be if I just returned the string "pizza" instead of this object?
		this.mapped = this.colors.map(function(color, i, list){
		  return {
				message: "I ♥ " + color.url.substr(7),
				backgroundHEX: color.background,
				colorHEX: color.textColor,
				width: color.pixels * (i + 1),
				length: color.pixels
			};
		});

		/* --------------------------------------------------------------------------------

			UNDERSCORE LIBRARY PATTERN:

			The _ is the name of the Underscore object. It's just a strange name but not special.
			Sort of like the following:

			var _ = {
								filter: function(){...},
								map: function(){...},
							};

			_.someUnderscoreFunction(Array, function(element, index, list) {
				// You have access to the array element, its index, and the original array list.
				return someThing;
			});

			_.filter(Array, predicateFunction);

			_.map(Array, iterateeFunction);

		-------------------------------------------------------------------------------- */

		/* --------------------------------------------------------------------------------

		SAME FUNCTIONS AS ABOVE BUT WITH UNDERSCORE.

		this.filtered = _.filter(this.colors, function(color, i, list){
		  return color.favorite === true;
		});

		this.mapped = _.map(this.colors, function(color, i, list){
			return {
				message: "I ♥ " + color.url.substr(7),
				backgroundHEX: color.background,
				colorHEX: color.textColor,
				width: color.pixels * (i + 1),
				length: color.pixels
			};
		});

		BASED ON YOUR UNDERSTANDING OF PREDICATES AND ITERATEES

		1) Can you use Underscore to SORT the original arrays by ID?
		2) Can you use Underscore to return a SHUFFLED (random order) array?
		3) Can you use Underscore to randomly SAMPLE 3 colors from the list?
		4) Can you use Underscore to figure out if EVERY id number is divisible by 7?
		5) Can you use Underscore to find the Color object with the MAX id?
		6) Can you use Underscore to find whether the id 93 is CONTAINED in the dataset?

		-------------------------------------------------------------------------------- */

		this.underscoreData = _.filter(this.colors, function(element, index, list){
			return true;
		});

	</script>

	<style>
		:scope {
			display: block;
		}
		div.color {
			padding: 10px;
		}
		a[href="http://placehold.it"] {
			background-color: tomato;
			padding: 0 15px;
		}
		.originalPre {
			background-color: oldlace;
		}
	</style>
</app>
