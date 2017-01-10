<basic>
	<strong>basic.tag</strong>
	<p>
		In this example, I use buttons and handlers to set this tag instance variable <code>this.backgroundColor</code> to various values.
	</p>
	<p>
		We use the click event for this demonstration. You'll notice that in Riot, we add the click event listener by using the attribute <code>onclick=\{ handlerFunction \}</code>. In Riot, any (I think) valid HTML event can be utilized by the <em><strong>on + eventname</strong></em> pattern. E.g.
		<ul>
			<li><code>onclick=\{ handlerFunction \}</code></li>
			<li><code>onkeypress=\{ ... \}</code></li>
			<li><code>onchange=\{ ... \}</code></li>
		</ul>
		You can find a full list of HTML Events to experiment with at <a href="http://www.w3schools.com/Tags/ref_eventattributes.asp" target="_blank">HTML Event Attributes</a>.
	</p>



	<!-- Basic event -->
	<div style={ "background:" + backgroundColor }>
		<button type="button" onclick={ setColor }>Set Color</button>
		<button type="button" onclick={ getRandomColor }>Random Color</button>
		<button type="button" onclick={ showInConsole }>Console Info</button>
		<p>
			The current color is: <span>{ backgroundColor }</span>
		</p>
	</div>



	<script>

		// Initial STATE of the tag bg color.
		this.backgroundColor = "rgb(255,255,0)"; // Yellow

		// Handlers
		this.setColor = function() {
			var r = prompt("RED: Enter number 0-255");
			var g = prompt("GREEN: Enter number 0-255");
			var b = prompt("BLUE: Enter number 0-255");

		  this.backgroundColor = `rgb(${r}, ${g}, ${b})`;
		};

		this.getRandomColor = function() {
			var r = Math.floor(Math.random() * 255);
			var b = Math.floor(Math.random() * 255);
			var g = Math.floor(Math.random() * 255);

			// Change the STATE of the tag bg color.
			this.backgroundColor = `rgb(${r}, ${g}, ${b})`;
		};

		// This is a shortcut / shorthand way of writing functions
		// in Riot tags. It is the same as...
		// this.showInConsole = function() { ... }
		showInConsole() {
			console.log("\nTag (this) Object:", this, "\n");
		}

	</script>

	<style>
		:scope {
			display: block;
			background: #F5F5F5;
			color: #333;
			padding: 15px;
		}
		div {
			padding: 15px;
		}
		code {
			background: #DDD;
			border-radius: 4px;
			padding: 0 4px 1px;
			color: #333;
		}
	</style>
</basic>
