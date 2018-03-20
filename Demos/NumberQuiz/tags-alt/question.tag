<question>

	<p>{ questionItem.question }</p>

	<number each={ num in questionItem.options } num-id={ questionItem.id } num-ref={ numRef } box-size={ boxSize } style={ numberStyles }></number>

	<p>QUESTION TAG - maxSize: { numRef[9].size }</p>

	<script>
		var that = this;

		this.numRef = this.opts.numRef;
		this.boxSize = this.opts.boxSize;
		this.numberStyles = {
			"font-size": this.boxSize + "em"
		};
		console.log(this.opts.numRef[9].size)

		this.on('update', function() {
			console.log('question update');
			this.numRef = this.opts.numRef;
			this.boxSize = this.opts.boxSize;
			this.numberStyles = {
				"font-size": this.boxSize + "em"
			};
		});

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
