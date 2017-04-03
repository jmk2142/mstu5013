<limerick>
	<p>In class exercise:</p>
	<p>Based on the data provided - create, initialize, and mount a Riot Tag that uses static data like that provided below to produce a limerick output.</p>
	<div class="poem">
		<p>There once was a <em>{ isMan ? "lad" : "lass"}</em> from <span class="fillin">{ place }</span>.</p>
		<p>Who ate only <span class="fillin">{ food }</span>.</p>
		<p><span class="fillin">{ altfood }</span>, ney.<br>None to this day.</p>
		<p>And so, <em>{ isMan ? "his" : "her" }</em> <span class="fillin">{ end }</span>.</p>
	</div>

	<img src="./images/data.png"/>

	<p>
		The following is alternative data that should produce an appropriate limerick if substituted for the above.
	</p>
	<img src="./images/data-alt.png"/> <img src="./images/poem-alt.png"/>

	<script>
		this.isMan = true;
		this.place = "New York";
		this.food = "bacon and pork";
		this.altfood = "Vegetables";
		this.end = "best friend is a fork";

		// this.isMan = false;
		// this.place = "Osaka";
		// this.food = "sushi and latkas";
		// this.altfood = "Whale meat";
		// this.end = "food was with vodka";
	</script>

	<style>
		:scope {
			font-size: 2.5em;
			font-family: Cambria;
		}
		img {
			max-height: 300px;
		}
		.poem {
			border: 1px solid #DDD;
			border-radius: .25em;
			padding: .5em;
			background-color: #F5F5F5;
			margin-bottom: 1em;
		}
		.fillin {
			text-decoration: underline;
		}
	</style>
</limerick>
