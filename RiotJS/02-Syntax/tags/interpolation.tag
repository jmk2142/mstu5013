<interpolation>

	<strong>interpolation.tag</strong>
	<p>
		The <em>{ wordOne }</em> ran to the <strong>{ wordTwo }</strong> and ate the <span>{ wordThree }</span>. Delicious!
	</p>
	<p>
		The words { wordOne }, { wordTwo }, and { wordThree } come from THIS tags javascript.<br>They are interpolated directly into the tag template.
	</p>
	<p>
		Look at the code. The curly braces <code>\{ \}</code>	in Riot tag templates mean we're working with Javascript.<br>Things inside \{ curly braces \} are treated like JS. Because they are special, if you want to actually write curly braces into your content as characters, you need to escape them with slashes <code>\\{ this is not evaluated \\}</code>.
	</p>

	<h3>Other demonstrations of interpolation:</h3>
	<ul>
		<li><strong>Number:</strong> { dataA } --- Answer to the Ultimate Question of Life, the Universe, and Everything</li>
		<li><strong>Boolean:</strong> { dataB ? "truthy" : "falsy" }</li>
		<li><strong>Array:</strong> { dataC[1] }</li>
		<li><strong>Object:</strong> { dataD.foodName } | { dataD.calories } cal/can | { dataD.origin }</li>
	</ul>

	<script>

		this.wordOne = "cat";
		this.wordTwo = "forest";
		this.wordThree = "salmon sushi";

		this.dataA = 42;
		this.dataB = false;
		this.dataC = ["sun","moon","planets"];
		this.dataD = {
			foodName: "Gourmet Catfood",
			calories: 600,
			origin: "Japan"
		};

	</script>

	<style>
		:scope {
			display: block;
			background: #0066FF;
			color: white;
			padding: 15px;
		}
		span, em, strong {
			text-decoration: underline;
		}
		code {
			background: #DDD;
			border-radius: 4px;
			padding: 0 4px 1px;
			color: #333;
		}
	</style>
</interpolation>
