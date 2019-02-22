<custom-tooltip>

	<p>Color: { opts.tooltipData.xLabel }</p>
	<p>Y Value: { opts.tooltipData.yLabel }</p>
	<p>blah { opts.x }</p>
	<button onclick={ doSomething }>Click</button>

	<script>
		var that = this;
		console.log('custom-tooltip.tag');

		doSomething(e) {
			alert(JSON.stringify(this.opts.tooltipData));
		}
	</script>

	<style>
		:scope {
			display: inline-block;
			background-color: dodgerblue;
			color: white;
			border-radius: 0.25em;
			padding: 0.25em;
		}
	</style>
</custom-tooltip>
