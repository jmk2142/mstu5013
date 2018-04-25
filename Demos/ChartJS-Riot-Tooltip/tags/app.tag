<app>

	<h1>CHART</h1>
	<canvas ref="myChart" width="100%"></canvas>

	<custom-tooltip ref="myTooltip" tooltip-data={ tooltipData }></custom-tooltip>

	<script>
		var tag = this;
		console.log('app.tag');
		this.toolText = "This is my text.";
		this.tooltipData = {};

		this.on('mount', function(){
			var ctx = this.refs.myChart.getContext('2d');
			this.chart = new Chart(ctx, {
				type: 'bar',
				data: {
				    labels: ["Red", "Blue", "Yellow", "Green", "Purple", "Orange"],
				    datasets: [{
				        label: '# of Votes',
				        data: [4,5,6,5,4,3,7],
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
				    }]
				},
				options: {
				  tooltips: {
						enabled: false,
						position: 'average',
						custom: function(tooltipModel){
						  var tooltipEl = tag.refs.myTooltip.root;

							// Question is when is this "custom" function executing?
							// console.log tells me this executes on every frame
							// console.log('tooltip', tooltipEl);

							// I want to update my tooltip (tag) on some condition...
							// Probably when the thing my cursor is over changes
							// So I have to look into where that data is to be found. more console.log
							// Turns out it has to do with callbacks, label... see below


							// Second question is, what is 'this' in this function context?
							// console.log(this);

							// `this` will be the overall tooltip
							var position = this._chart.canvas.getBoundingClientRect();

							tooltipEl.style.opacity = 1;
              tooltipEl.style.position = 'absolute';
              tooltipEl.style.left = position.left + tooltipModel.caretX + 'px';
              tooltipEl.style.top = position.top + tooltipModel.caretY + 'px';


						},
						callbacks: {
							// This seems to be the callback that is called when the mouse is hovering
							// over a tooltip trigger area
							// Note this is triggered on any mouse movement in the trigger area
							// So it's fine for little dynamic things (like click stuff in the tooltip)... but if your tooltip riot tag is going to do something like a firebase query -... it's going to fire off a query many many times. So you need some control to only query if for example, the value has changed. etc.
							label: function(tooltipItem, data) {
							  console.log('TOOLTIPITEM:', tooltipItem);
								console.log('DATA:', data)
								tag.tooltipData = tooltipItem;
								tag.update();
							}
						}
					}
				}
		});

		});
	</script>

	<style>
		:scope {
			display: block;
		}
	</style>
</app>
