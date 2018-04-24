<app>

	<h1>CHART JS in Riot</h1>
	<canvas ref="myChart" width="100%"></canvas>

	<script>
		var that = this;

		// Canvas element isn't available until after this tag is mounted.
		// ChartJS requires the canvas element, so we use a lifecycle event.
		this.on('mount', function() {

			console.log('mount');

			var ctx = this.refs.myChart.getContext('2d');
			var myChart = new Chart(ctx, {
				type: 'bar',
				data: {
					labels: [ "Red", "Blue", "Yellow", "Green", "Purple", "Orange" ],
					datasets: [
						{
							label: '# of Votes',

							// This might come from the database.
							// We know it requires an array of numbers.
							// Question is how do we convert the shape of our data from the DB
							// To a format that ChartJS wants?
							data: [ 12,19,3,5,2,3 ],
							backgroundColor: [
								'rgba(255, 99, 132, 0.2)',
								'rgba(54, 162, 235, 0.2)',
								'rgba(255, 206, 86, 0.2)',
								'rgba(75, 192, 192, 0.2)',
								'rgba(153, 102, 255, 0.2)',
								'rgba(255, 159, 64, 0.2)'
							],
							borderColor: [
								'rgba(255,99,132,1)',
								'rgba(54, 162, 235, 1)',
								'rgba(255, 206, 86, 1)',
								'rgba(75, 192, 192, 1)',
								'rgba(153, 102, 255, 1)',
								'rgba(255, 159, 64, 1)'
							],
							borderWidth: 1
						}
					]
				},
				options: {
					scales: {
						yAxes: [
							{
								ticks: {
									beginAtZero: true
								}
							}
						]
					}
				}
			});
		});

		this.on('updated', function() {
			console.log('updated');
		});
	</script>

	<style>
		:scope {
			display: block;
		}
	</style>
</app>
