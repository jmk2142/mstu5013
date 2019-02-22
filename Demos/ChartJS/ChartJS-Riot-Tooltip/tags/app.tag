<app>

	<h1>CHART</h1>
	<canvas ref="myChart" width="100%"></canvas>

	<input type="number" ref="score">
	<select ref="dayOfWeek" onchange={ setDay }>
		<option value="m">Monday</option>
		<option value="t">Tuesday</option>
	</select>
	<button onclick={ setNumber }>Enter Number</button>

	<custom-tooltip ref="myTooltip" tooltip-data={ tooltipData } x={"Jin"}></custom-tooltip>

	<script>
		var tag = this;
		console.log('app.tag');
		this.toolText = "This is my text.";
		this.tooltipData = {};
		this.day = 'm';

		// Assume Monday
		// this.day = 0;

		setDay(e) {
			this.day = this.refs.dayOfWeek.value;
		}

		// Assume this is what we get from FB
		// this.fbData = [{
		// 	score: 0,
		// 	comment: "x"
		// },{
		// 	score: 1,
		// 	comment: "x"
		// },{
		// 	score: 5,
		// 	comment: "x"
		// },{
		// 	score: 10,
		// 	comment: "x"
		// },{
		// 	score: 3,
		// 	comment: "x"
		// }];

		scoresRef.on('value', function(snap){
		  console.log(snap.val());
			var data = Object.values(snap.val());

			var justScores = data.map(function(obj){
			  return obj.score;
			});
			console.log(data);
			console.log(justScores);

			tag.chart.data.datasets[0].data[0] = justScores[0];
			tag.chart.data.datasets[0].data[1] = justScores[1];

			tag.chart.update();
		});


		// this.justScores = this.fbData.map(function(obj){
		//   return obj.score;
		// });



		setNumber(e) {
			var score = this.refs.score.value;

			console.log(this.chart.data.datasets);

			scoresRef.child(this.day + '/score').set(score);

			// this.chart.data.datasets[0].data[this.day] = score;
			// this.chart.data.labels[0] = 'MONDAY';
			//
			// this.chart.update();
		}


		this.on('mount', function(){
			var ctx = this.refs.myChart.getContext('2d');
			this.chart = new Chart(ctx, {
				type: 'bar',
				data: {
				    labels: ["M", "T", "W", "R", "F"],
				    datasets: [{
				        label: '# of Votes',
				        data: this.justScores,
								lineTension: 0,
				        backgroundColor: [
				            'rgba(255, 99, 132, 0.2)',
				            'rgba(54, 162, 235, 0.2)',
				            'rgba(255, 206, 86, 0.2)',
				            'rgba(75, 192, 192, 0.2)',
				            'rgba(153, 102, 255, 0.2)'
				        ],
				        borderColor: [
				            'rgba(255,99,132,1)',
				            'rgba(54, 162, 235, 1)',
				            'rgba(255, 206, 86, 1)',
				            'rgba(75, 192, 192, 1)',
				            'rgba(153, 102, 255, 1)'
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
