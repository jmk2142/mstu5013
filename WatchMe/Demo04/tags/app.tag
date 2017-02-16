<app>
	<strong>app.tag</strong>
	<p ref="alpha">
		{ x } <button onclick={ changeX }>Change X</button>
	</p>

	<input type="password" ref="passwordinput" placeholder="Enter Password">
	<button type="button" onclick={ login }>LOGIN</button>

	<child></child>

	<script>
		console.log('app.tag');

		this.x = "xxx";
		this.y = {animal:"tiger"};
		this.z = null;
		this.w = function(event){
		  console.log('function w');
		};
		this.changeX = function(event){
		  this.x = "Xylophone";
			console.log(this);
		};

		this.login = function(event){
			alert(this.refs.passwordinput.value);
		};

		console.log(this);

	</script>

	<style>
		:scope {
			display: block;
			border: 1px solid #DDD;
			border-radius: 4px;
			padding: 10px;
			font-family: Helvetica;
		}

	</style>
</app>
