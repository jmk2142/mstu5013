<cuisines>

	<h3>CUISINES for: { opts.food.type }</h3>

	<recipe each={ recipe in recipes }></recipe>

	<button type="button" onclick={ goBack }>BACK</button>

	<script>
		var that = this;
		console.log('cuisines.tag', this.opts.food);



		// Simulates FB Data Structure cuisines/carrots etc.
		var cuisines = {
			carrots: [{recipe: 'Carrot Cake'},{recipe: 'Carrot Salad'},{recipe: 'Carrot Soup'}],
			chicken: [{recipe: 'Chicken Burrito'},{recipe: 'Chicken Pot Pie'}],
			apples: [{recipe: 'Apple Pie'}]
		};

		this.recipes = cuisines[this.opts.food.type];
		console.log(this.recipes);

		goBack(e) {
			observable.trigger('cuisines:unload');
		}


	</script>

	<style>
		:scope {
			display: block;
		}
	</style>
</cuisines>
