<tag-internal>
	<strong>tag-internal.tag</strong>
	<p>
		The following preformatted output is the current tag, <code>this</code> tag in it's object representative form.
	</p>
	<p>Compare the source code with this output. Notice how <code>localX_fruit</code> data sits at the base of the tag object.</p>
	<ul>
		<li><code>this</code> is the current instance of the tag object.</li>
		<li><code>localA_pple</code> is a property of this tag object instance.</li>
	</ul>

	<pre>this = { tagJSON }</pre>

	<p>The takeaway is that whenever you set <code>this.dataSomething</code> in your Riot markup, it is saved as a property at the base of the current tag object.</p>
	<p>This is a way to keep track of important data relevant to this particular tag. That is, data represents the <em>state</em> of this tag. For example, if the visual of the tag reacts based on whether the state of the user is logged in or not. E.g. <code>this.loggedIn = true; // false;</code> then <code>loggedIn</code> can be seen as the data source, the truth of all that matters, that will represent the state of this tag component.</p>

	<p>Note that while Riot allows you to add your own custom data properties for the tag, it also comes with some of it's own.</p>
	<p>For example, notice the property called <code>opts</code> with the value of <code>\{\}</code>. We'll discuss this special property next.</p>

	<script>
		var tag = this;

		this.localA_pple = "Tasty";
		this.localB_anana = true;
		this.localC_orn = [1,2,3];
		this.localD_aikon = { id:"Data D", comment:"What a fine piece of data." };

		this.localE_ggplant = function(event) {
		  console.log('Eggplant parmesian');
		};

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
	</style>
</tag-internal>
