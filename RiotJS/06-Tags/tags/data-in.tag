<data-in>
	<strong>data-in.tag <span>{ opts.mylabel }</span></strong>

	<pre>this = { tagJSON }</pre>

	<script>
		var tag = this;

		console.log(this);

		this.tagJSON = JSON.stringify(this, censor(this), 2);

	</script>

	<style>
		:scope {
			display: block;
		}
		pre {
			border: 1px solid #DDD;
			border-radius: 4px;
			padding: 10px;
		}
		code {
			background: #DDD;
			border-radius: 4px;
			padding: 0 4px 1px;
			color: #333;
		}
		strong > span {
			color: red;
		}
	</style>
</data-in>
