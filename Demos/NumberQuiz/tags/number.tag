<number>

	<div style={ myStyles() }>{ opts.num }</div>

	<script>
		var that = this;
		console.log('number.tag', this);

		myStyles() {
			var size;

			if (this.opts.factor === 0) {
				size = 1;
			} else {
				size = this.opts.num * this.opts.factor;
			}

			return `font-size:${ size }em`;
		}
	</script>

	<style>
		:scope {
			display: inline-block;
			text-align: center;
			vertical-align: middle;
			border: 1px solid tomato;

			width: 8em;
			height: 8em;
			line-height: 8em;

			padding: 20px;
			margin-bottom: 1em;
		}
		div {
			font-size: 20px;
		}
	</style>
</number>
