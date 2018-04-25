<food onclick={ gotoCuisines }>

	<div>{ food.type }</div>

	<script>
		var that = this;
		console.log('food.tag');

		gotoCuisines(e) {
			observable.trigger('cuisines:load', this.food);
		}
	</script>

	<style>
		:scope {
			display: inline-block;
			border: 2px solid green;
			padding: 1em;
			margin-right: 1em;
			cursor: pointer;
		}
	</style>
</food>
