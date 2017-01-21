<setup>
	<strong>setup.tag</strong>
	<p>First, notice that you need to add the Riot router script in your page like so. (See bottom of this index.html)</p>
	<code>&lt;script src=&quot;https://cdn.jsdelivr.net/riot-route/3.0/route.min.js&quot;&gt;&lt;/script&gt;</code>
	<p>While there are many ways to implement the router, most times at this level we're really wanting to use the router to just switch to another "page" or component.</p>

	<!-- Navigation Component -->
	<menu-baking activepage={ page }></menu-baking>

	<!-- Content Components -->
	<content-cakes if={ page === "cakes" }></content-cakes>
	<content-cookies if={ page === "cookies" }></content-cookies>
	<content-breads if={ page === "breads" }></content-breads>
	<div id="home" if={ page === "home" }>
		<p>This is my home.</p>
	</div>

	<script>
		var that = this;

		this.page = "home";

		// Routing Setup
		// http://localhost:8080/RiotJS/07-Router/#urlFragmentA/urlFragmentB/urlFragmentC/...
		// Whenever URL changes, run this function, pass in the fragments
		route(function(urlFragmentA, urlFragmentB, urlFragmentC) {
			console.log(urlFragmentA, urlFragmentB, urlFragmentC);

			that.page = urlFragmentA;
			that.update();
		});

		// Start the router and execute it [true]
		route.start(true);
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
		#home {
			background-color: #03a9f4;
			padding: 15px;
		}
		content-cakes, content-cookies, content-breads {
			padding: 15px;
		}
	</style>

</setup>
