<telegram>

	<p>This is a telegram <span>x</span>...</p>

	<!-- Why won't this work? -->
	<p>TO: { to }</p>
	<p>FROM: { telegram.from }</p>
	<p>MESSAGE: { telegram.msg }</p>

	<script>
		var that = this;
		console.log('telegram.tag', this);
	</script>

	<style>
		:scope {
			display: block;
			border: 1px solid dodgerblue;
			padding: 1em;
			margin-bottom: 1em;
		}
		span {
			color: tomato;
		}
	</style>
</telegram>
