<expressions>
	<strong>expressions.tag</strong>
	<p>
		In RiotJS, you can have pure javascript expressions directly inside your curly braces. Variables inside curly braces reference <code>this</code> tag object. E.g. <code>&lt;div id=\{x\}&gt;&lt;/div&gt;</code> and <code>this.x = "abc123"</code> becomes <code>&lt;div id=&quot;abc123&quot;&gt;&lt;/div&gt;</code>. Therefore, in your JS portion of the tag, you'll notice that we write out <code>this.varName</code> while inside the template we refer to <code>this</code> tag instance automatically. Inspect the following HTML to see the values and compare them to the source code from the repository.
	</p>

	<section>
		<!-- Common way (fixed) -->
		<div id="fixedID" class="fixedClassA fixedClassB">FIXED</div>

		<!-- Dynamic, templated way using Riot -->
		<div id={ someID }>A</div>

		<!-- Generating an ID string -->
		<div id={ "xyz-" + someNumber }>B</div>

		<!-- Generating classes -->
		<div id="myID" class={ independent ? "cat" : "dog" }>C</div>

		<!-- Evalutating multiple classes -->
		<div class={ classA: true, classB: null, classC:"zzz", classD: undefined, classE: new Object(), classF:0 }>D</div>

		<!-- URLs as dynamic expressions -->
		<img src={ imgURL } alt="placehold.it image" />

		<!-- Data from function calls -->
		<div>
			{ this.today() }
		</div>

		<!-- Styles (generally avoid inline styles, except when dynamic) -->
		<div style={ "background-color: " + getRandColor() }>Random Color A</div>
		<div style={ "background-color: " + getRandColor() }>Random Color B</div>
		<div style={ "background-color: " + getRandColor() }>Random Color C</div>
	</section>




	<script>

		this.someID = "abracadabra";
		this.someNumber = Math.floor(Math.random() * 100);

		this.independent = (true && false);

		var dimensions = "100x100";
		this.imgURL = "https://placehold.it/" + dimensions;

		this.today = function() {
		  return new Date();
		};

		this.getRandColor = function() {
		  var r = Math.floor(Math.random() * 255);
			var g = Math.floor(Math.random() * 255);
			var b = Math.floor(Math.random() * 255);

			return `rgb(${r},${g},${b})`;
		};

	</script>


	<style>
		:scope {
			display: block;
			background: #00FF66;
			padding: 15px;
		}

		section {
			display: flex;
			flex-wrap: wrap;
		}

		div, img {
			flex-basis: 20%;
			box-sizing: border-box;
			height: 100px;
			width: 100px;
			padding: 10px;
			background: rgba(255,255,255,.2);
			border: 1px solid #333;
			margin: 0 10px 10px 0;
			color: #333;
			font-size: .75em;
		}

		code {
			background: #DDD;
			border-radius: 4px;
			padding: 0 4px 1px;
			color: #333;
		}
	</style>
</expressions>
