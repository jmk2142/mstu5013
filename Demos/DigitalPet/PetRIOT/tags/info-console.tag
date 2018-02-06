<info-console>

	<div show={ logList }>
		<div>GAME LOG:</div>
		<pre><virtual each={ log in logList }>{ log }<br /></virtual></pre>
	</div>


	<script>
		var that = this;
		console.log('info-console.tag');

		this.on('update', function() {
			var clone = this.opts.logs.slice(0);

		  this.logList = clone.reverse();
		});

	</script>

	<style>
		:scope {
			display: block;
			margin-top: 1em;
		}
	</style>
</info-console>
