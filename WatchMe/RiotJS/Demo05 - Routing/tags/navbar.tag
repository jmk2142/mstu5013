<navbar>
	<nav>
		<a href="#page-a">Page A</a>
		<a href="#page-b">Page B</a>
		<a href="#page-c">Page C</a>
	</nav>

	<script>
		var that = this;
		console.log('navbar.tag');
	</script>

	<style>
		:scope {
			display: block;
		}
		nav {
			display: flex;
		}
		nav a {
			display: block;
			flex-grow: 1;
			background-color: tomato;
			padding: 10px;
			text-decoration: none;
			color: #333;
			font-weight: bold;
		}
		nav a:not(:last-child) {
			margin-right: 1px;
		}
		nav a:hover {
			background-color: gold;
		}
	</style>
</navbar>
