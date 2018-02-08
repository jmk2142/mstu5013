<info-console>

	<div>
		<div>GAME LOG:</div>
		<pre show={ logList.length > 0 }><virtual each={ log in logList }>{ log }<br /></virtual></pre>
		<div hide={ logList.length > 0 } ref="noLog">NO LOGS AVAILABLE</div>
	</div>


	<script>
		var that = this;

		this.logList = [];

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
		[ref="noLog"] {
			margin-top: 1em;
			color: silver;
		}
	</style>
</info-console>
