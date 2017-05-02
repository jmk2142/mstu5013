<sorter>

	<br>
	<h3>SORTING</h3>
	<div class="row">
		<div class="col-md-4">
			<select class="form-control" ref="manipulation" onchange={ sortMyData }>
				<option value="" checked>Select</option>
				<option value="sortAscending">Sort Ascending</option>
				<option value="sortDescending">Sort Descending</option>
				<option value="sortRandom">Sort Randomized</option>
			</select>
		</div>
	</div>
	<br>
	<div class="color" each={ sortedData }>
		<div>ID: { id }</div>
		<img src={ url }>
	</div>


	<script>
		var that = this;
		this.colors = this.opts.colors;
		this.sortedData = this.colors;

		this.sortType = "default";

		this.sortMyData = function(event) {
			console.log('sortMyData()');

			var sortType = event.target.value;
			this.sortType = sortType;

			if (this.sortType === 'sortAscending') {
				// Manipulate the array into an Ascending order.
				// this.sortedData = ...;
			}

			if (this.sortType === 'sortDescending') {
				// ...
			}

			if (this.sortType === 'sortRandom') {
				// ...
			}

			if (this.sortType === 'default') {
				// ...
			}
		};

	</script>

	<style>
		:scope {
			display: block;
		}
		.color {
			position: relative;
			display: inline-block;
		}
		.color > div {
			position: absolute;
			font-weight: bolder;
			font-size: 10px;
			padding: 5px;
			color: tomato;
		}
	</style>
</sorter>
