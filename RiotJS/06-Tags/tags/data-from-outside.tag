<data-from-outside>
	<strong>data-from-outside.tag</strong>
	<p>Up until now, the source of our tag data has come from internally defining the data in our tag instances. But sometimes, you want to pass data INTO a tag from the outside. There are two ways to do this.</p>
	<ul>
		<li>If you are directly mounting a tag you can pass the data in as the second argument.<ul>
			<li>E.g. <code>riot.mount('tag', \{ username:"jmk2142" \} );</code></li>
		</ul></li>
		<li>If you are passing data from a parent tag to a child tag, you can pass them in as <em>"html" attributes</em><ul>
			<li>E.g. <code>&lt;child-tag username=\{ &quot;jmk2142&quot; \} &gt;&lt;/child-tag&gt;</code></li>
		</ul></li>
	</ul>

	<section>
		<div class="example">
			<strong>Markup</strong>
			<pre>&lt;data-in&gt;</pre>

			<data-in></data-in>

			<p>Nothing is passed in. <code>opts = \{\}</code></p>
		</div>
		<div class="example">
			<strong>Markup</strong>
			<pre>&lt;data-in mylabel=\{&quot;A&quot;\} first=\{firstName\} last=\{lastName\}&gt;</pre>

			<data-in mylabel={ "A" } first={ firstName } last={ lastName }></data-in>

			<p>Data passed in directly or by references.</p>
		</div>
		<div class="example">
			<strong>Markup</strong>
			<pre>&lt;data-in mylabel=\{&quot;B&quot;\} food=\{cleanData\}&gt;</pre>
			
			<data-in mylabel={ "B" } food={ cleanData }></data-in>
			
			<p>See the source code and compare the parent data with the <code>opts</code> property in the child.</p>
		</div>
	</section>

	<script>
		this.firstName = "Barack";
		this.lastName = "Obama";
		this.lunch = {
			foodName: "Grilled Cheese",
			healthy: false
		};
		this.favorites = ["Pizza","Mountain Dew","Doritos"];

		this.cleanData = {
			first: this.firstName,
			last: this.lastName,
			lunch: this.lunch,
			favorites: this.favorites
		};
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
		li {
			margin-bottom: 10px;
		}
		section {
			display: flex;
			justify-content: space-between;
		}
		.example {
		}
	</style>
</data-from-outside>
