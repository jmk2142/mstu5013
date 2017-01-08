<expressions>
	<strong>expressions.tag</strong>
	<p>
		In RiotJS, you can have pure javascript expressions directly inside your curly braces. Variables inside curly braces reference <em>this</em> tag object. Therefore, in your JS portion of the tag, you'll notice that we write out <em>this.varName</em> while inside the template we refer to <em>this</em> automatically. E.g. <div id="{ this.id }"></div>
	</p>

	<style>
		:scope {
			display: block;
			background: #00FF66;
			padding: 15px;
		}
	</style>
</expressions>
