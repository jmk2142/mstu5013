<question>

	<p>{ item.question }</p>

	<label each={ num in item.options }>
		<input type="radio" name={ item.id } value={ num }>
		<number num={ num } factor={ opts.factor }></number>
	</label>


	<script>
		var that = this;
		console.log('question.tag');
	</script>

	<style>
		:scope {
			display: block;
			border: 1px solid dodgerblue;
			padding: 1em;
			margin-bottom: 1em;
		}
	</style>
</question>
