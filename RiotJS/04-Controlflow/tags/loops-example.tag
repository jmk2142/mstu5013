<loops-example>
	<strong>loops-example.tag</strong>
	<p>
		Note that this is an important technique. In this example we'll demonstrate how to <em>loop</em> through data and templates real easily in Riot. Riot does all the work for us with the special attribute <code>each=\{ arrayCollection \}</code>.
	</p>

	<ol>
		<li each={ motorcycles }><strong>{ make }</strong> - { model || "Unknown" }</li>
	</ol>
	<div class="gallery">
		<img each={ motorcycles } src={ url } alt={ make + " " + model }/>
	</div>

	<!--
		Notice that motorcycles refers to this.motorcycles, that is - this refers to the current loops-example tag.

		However, for the <li> we are not saying motorcycles[0].make, motorcycles[1].make, ...

		When `each` is used, for each element Riot automatically creates a new (child) tag instance. You'll notice that in the console (see below), you can view the loop tag and each item tag and it's properties.

		Each child tag represents a motorcycle object. A motorcycle object's properties are directly attached to the children tags that are created. The keyword `this` in the children tags represent the child tag, not the current (parent) <loops-example> tag.
	-->
	{ console.log('B - LOOP TAG:', this); }
	<virtual each={ motorcycles }>{ console.log('B - ITEM TAG:', this); }</virtual>


	<script>
		// Source of truth data... our collection of objects
		this.motorcycles = [
			{ model: "Grom", make: "Honda", url:"http://bit.ly/2iC2bbf" },
			{ model: "Custom", make: "Derringer", url:"http://bit.ly/2ifTSEb" },
			{ model: "R60", make: "BMW", url:"http://bit.ly/2j4O7KM" },
			{ model: "", make: "MAC", url: "http://bit.ly/2jrNMOK" },
			{ model: "C3 X132 Hellcat", make: "Confederate", url: "http://bit.ly/2iC5ijo" }
		];

		this.xxx = "Test Parent String";
	</script>








	<style>
		:scope {
			display: block;
			background: #00bcd4;
			padding: 15px;
		}
		.gallery {
			display: flex;
			vertical-align: middle;
			justify-content: space-between;
		}
		img {
			max-height: 100px;
			/*width: 20%;*/
		}
	</style>
</loops-example>
