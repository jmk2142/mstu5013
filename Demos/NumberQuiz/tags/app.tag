<app>

	<question each={ item in data } factor={ factor }></question>

	<script>
		var that = this;
		console.log('app.tag');

		// SIZE factor
		// 0 means no change, all same size.
		// 1 means each font-size is number value x 1
		// e.g. 100, 200, 300, 400, 500
		this.factor = 2;
		this.maxSize;
		this.minSize;


		this.data = [{
			id: "a",
			question: "What is the largest number?",
			options: [9,1,9,1,5],
			correct: 4
		},{
			id: "b",
			question: "What is the smallest number?",
			options: [5,6,7,8],
			correct: 5
		},{
			id: "c",
			question: "What is the largest prime number?",
			options: [2,3,5,7],
			correct: 7
		},{
			id: "d",
			question: "What is the smallest prime number?",
			options: [2,9,5,1],
			correct: 7
		}];

	</script>

	<style>
		:scope {
			display: block;
		}
	</style>
</app>
