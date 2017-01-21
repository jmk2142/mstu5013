<menu-baking>
	<ul>
		<li class={ current:(active === "home") }>
			<a href="#home">Home</a>
		</li>
		<li class={ current:(active === "cakes") }>
			<a href="#cakes">Cakes</a>
		</li>
		<li class={ current:(active === "cookies") }>
			<a href="#cookies/oreos">Cookies</a>
		</li>
		<li class={ current:(active === "breads") }>
			<a href="#breads/leven/italian">Breads</a>
		</li>
	</ul>

	<script>
		this.active = this.opts.activepage;

		this.on('update', function(){
			this.active = this.opts.activepage;
		});
	</script>

	<style>
		:scope {
			display: block;
			background-color: #DDD;
		}
		ul {
			list-style: none;
			padding-left: 0;
			display: flex;
			margin-bottom: 0;
			border-bottom: 1px solid #FFF;
		}
		li {
			background-color: #333;
			position: relative;
			flex-grow: 1;
			text-align: center;
		}
		li:not(:last-child) {
			border-right: 1px solid #FFF;
		}
		li > a {
			box-sizing: border-box;
			display: inline-block;
			padding: 15px;
			cursor: pointer;
			width: 100%;
			color: #FFF;
			transition: background-color .5s;
		}
		li > a:hover {
			background-color: #ffc107;
			color: #FFF;
		}
		li > a:visited {
			color: #FFF;
		}
		.current {
			background-color: #f44336;
		}
	</style>
</menu-baking>
