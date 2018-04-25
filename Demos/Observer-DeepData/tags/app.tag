<app>

	<div if={ !showingCuisines }>
		<h3>Food TYPES</h3>
		<food each={ food in foods }></food>
	</div>

	<cuisines if={ showingCuisines } food={ loadedFood }></cuisines>

	<script>
		var that = this;

		this.showingCuisines = false;
		this.loadedFood = null;

		// Food types
		this.foods = [{ type: 'carrots' }, { type: 'chicken'}, { type: 'apples'}];

		// Observables - this way, doesn't matter how nested things are.
		// Tags can talk to each other and send data through the observable object.
		// See index to see the observable variable declaration.
		observable.on('cuisines:load', function(data) {
			that.showingCuisines = true;
			that.loadedFood = data;
			that.update();
		});

		observable.on('cuisines:unload', function(){
			that.showingCuisines = false;
			that.loadedFood = null;
			that.update();
		});


	</script>

	<style>
		:scope {
			display: block;
		}
	</style>
</app>
