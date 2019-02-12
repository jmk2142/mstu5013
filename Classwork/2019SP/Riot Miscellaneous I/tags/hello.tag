<hello>
	<h1>Hello world! { firstName }</h1>
	<p class={ vip:(name === "Alpha") } hide={ textHidden }>Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.</p>
	<button type="button" onclick={ setName }>PUSH</button>
	<button type="button" onclick={ toggleHidden } hide={ textHidden }>Hide</button>
	<button type="button" onclick={ toggleHidden } show={ textHidden }>Show</button>

	<script>
		var tag = this;

		this.names = ["Alpha","Bravo","Charlie"];
		this.name = this.names[Math.floor(Math.random() * this.names.length)];

		this.textHidden = false;

		setName() {
			this.name = this.names[Math.floor(Math.random() * this.names.length)];
		}
		toggleHidden() {
			this.textHidden = !this.textHidden;
		}

	</script>

	<style>
		:scope {
			display: block;
			border: 1px solid blue;
			padding: 1em;
			border-radius: 0.5em;
			margin: 1em;
		}
		.vip {
			color: green;
		}
	</style>

</hello>
