<question>

	<p>{ quizItem.question }</p>
	<label each={ choice in quizItem.choices }>
		<input type="radio" name={ quizItem.id } value={ quizItem.answer } onclick={ setAnswer }></input> { choice }
	</label>


	<script>
		var that = this;
		console.log('question.tag');
		console.log(this);

		setAnswer(e) {
			this.userAnswer = e.item.choice;
			console.log(this.userAnswer);
			if (this.userAnswer == this.quizItem.answer) {
				this.quizItem.isCorrect = true;
			} else {
				this.quizItem.isCorrect = false;
			}
		}
	</script>

	<style>
		:scope {
			display: block;
		}
		label {
			display: block;
		}
	</style>
</question>
