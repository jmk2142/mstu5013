<app class="row">

	<div class="col">
		<div class="card">
			<div class="card-header">
				Chart A - This chart is staic
			</div>
		  <div class="card-body">
		    <canvas ref="chartA" width="100%"></canvas>
		  </div>
		</div>
	</div>

	<div class="col">

		<div class="card">
			<div class="card-header">
				Chart B - This chart updates
			</div>
			<div class="card-body">
				<div class="card-text">
					<canvas ref="chartB"></canvas>
				</div>
			</div>
			<div class="card-footer">
				<button class="btn btn-danger" onclick={ remove }>REMOVE ANIMAL</button>
				<button class="btn btn-success" onclick={ add }>ADD ANIMAL</button>
			</div>
		</div>

	</div>

	<div class="col">
		<div class="card">
			<div class="card-header">
				Chart C
			</div>
		  <div class="card-body">
		    <canvas ref="chartC" width="100%"></canvas>
		  </div>
		</div>
	</div>

	<script>
		// JAVASCRIPT
		let tag = this;

		// This data could come from a database.
		this.zoo = [
			{
				type: "cat",
				age: 10,
				alive: true
			}, {
				type: "cat",
				age: 5,
				alive: true
			}, {
				type: "cat",
				age: 14,
				alive: false
			}, {
				type: "dog",
				age: 8,
				alive: false
			}, {
				type: "dog",
				age: 1,
				alive: true
			}, {
				type: "bird",
				age: 60,
				alive: true
			}
		];

		remove(event) {
			event.preventUpdate = true;
			var animal = this.zoo.pop();
			updateChart(this.chartB, this.zoo);
			updateChart(this.chartC, this.zoo);
			
			console.log("Removed: ", animal);
			console.log("this.zoo: ", this.zoo);
		}

		add(event) {
			event.preventUpdate = true;
			var animal = {
				type: _.sample(['cat','dog','bird']),
				age: _.random(1, 16),
				alive: _.sample([true, false])
			};
			this.zoo.push(animal);
			updateChart(this.chartB, this.zoo);
			updateChart(this.chartC, this.zoo);

			console.log("Added: ", animal);
			console.log("this.zoo: ", this.zoo);
		}

		function updateChart(chart, arr) {
			chart.data.labels = _.chain(arr).map(animal => animal.type).uniq().value();

			chart.data.datasets.forEach(dataset => {
				dataset.data = _.chain(arr).groupBy('type').map(animalType => animalType.length).value()
			});

			chart.update();
		}

		this.on('mount', function() {

			this.chartARoot = this.refs.chartA.getContext('2d');
			this.chartBRoot = this.refs.chartB.getContext('2d');
			this.chartCRoot = this.refs.chartC.getContext('2d');

			this.chartA = new Chart(this.chartARoot, {
				type: 'doughnut',
				data: {
					labels: ['cat', 'dog', 'bird'],
					datasets: [{
						label: 'X',
						data: [3, 2, 1],
						backgroundColor: ['tomato', 'silver', 'dodgerblue'],
						borderWidth: 0
					}]
				},
				options: {}
			});

			this.chartB = new Chart(this.chartBRoot, {
				type: 'pie',
				data: {
					labels: _.chain(this.zoo).map(animal => animal.type).uniq().value(),
					datasets: [{
						data: _.chain(this.zoo)
										.groupBy('type')
										.map(animalType => animalType.length)
									.value(),
						backgroundColor: ['tomato', 'silver', 'dodgerblue'],
						borderWidth: 0
					}]
				},
				options: {}
			});

			this.chartC = new Chart(this.chartCRoot, {
				type: 'horizontalBar',
				data: {
					labels: _.chain(this.zoo).map(animal => animal.type).uniq().value(),
					datasets: [{
						label: "Animals",
						data: _.chain(this.zoo)
										.groupBy('type')
										.map(animalType => animalType.length)
									.value(),
						backgroundColor: ['tomato', 'silver', 'dodgerblue'],
						borderWidth: 0
					}]
				},
				options: {
					scales: {
						xAxes: [{
							ticks: {
								min: 0
							}
						}]
					}
				}
			});

		});

	</script>

	<style>
		/* CSS */
		:scope {
			display: block;
		}
	</style>
</app>
