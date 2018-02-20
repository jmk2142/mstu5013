<app>
	<h1>TEST APP QUIZ</h1>

	<question each={ quizQuestions }></question>

	<script>
		var that = this;
		console.log('app.tag');

		this.quizQuestions = [
			{
				question: "What's bigger, the earth or the sun?",
				choices: [
					"earth",
					"sun",
					"both the same"
				],
				youtubeID: "Ydfsifdls",
				answer: "sun"
			},
			{
				question: "Do you believe in God?",
				choices: [
					"yes",
					"no",
					"kind of..."
				],
				youtubeID: "ABDE3482",
				answer: "kind of..."
			}
		];
	</script>

	<style>
		:scope {
			display: block;
		}
	</style>
</app>
