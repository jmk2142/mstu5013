<subnav>

	<nav>
		<a href="#page-b/cookies">Cookies</a>
		<a href="#page-b/cakes">Cakes</a>
		<a href="#page-b/breads">Breads</a>
	</nav>

	<script>
		var that = this;
		console.log('subnav.tag');
	</script>

	<style>
		:scope {
			display: block;
		}
		nav {
			display: flex;
		}
		nav a {
			width: 33.33333333%;
			display: block;
			background-color: gold;
			padding: 10px;
			text-decoration: none;
			color: #333;
			font-weight: bold;
			text-align: center;
		}
		nav a:not(:last-child) {
			margin-right: 1px;
		}
		nav a:hover {
			background-color: oldlace;
		}
	</style>
</subnav>
