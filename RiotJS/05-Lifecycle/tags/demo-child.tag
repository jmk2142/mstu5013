<demo-child>
	<strong>demo-child.tag</strong>
	<p>{ name } - { letters[letterIndex] }</p>
	<button onclick={ cycleLetter }>Cycle Letter</button>
	<button onclick={ parent.removeChildTag }>Remove</button>

	<script>
		alert('demo-child: INITIALIZED CODE');
		console.log('demo-child: INITIALIZED CODE');

		this.letterIndex = 0;
		this.letters = ["Yurt", "Xylophone", "Zoo"];

		this.cycleLetter = function(event) {
			console.log('--------------------\n', 'CLICKED cycleLetter');
			this.letterIndex = (this.letterIndex < 2) ? (this.letterIndex + 1) : 0;
		};

		this.on('before-mount', function(event) {
			alert('demo-child.tag before-mount');
			console.log('demo-child.tag before-mount');
		});

		this.on('mount', function(event) {
		  alert('demo-child.tag mount');
			console.log('demo-child.tag mount');
		});

		this.on('update', function(event) {
		  alert('demo-child.tag update');
			console.log('demo-child.tag update');
		});

		this.on('updated', function(event) {
		  alert('demo-child.tag updated');
			console.log('demo-child.tag updated');
		});

		this.on('before-unmount', function(event) {
		  alert('demo-child.tag before-unmount');
			console.log('demo-child.tag before-unmount');
		});

		this.on('unmount', function(event) {
		  alert('demo-child.tag unmount');
			console.log('demo-child.tag unmount');
		});

		alert('demo-child: LOADED CODE');
		console.log('demo-child: LOADED CODE\n--------------------');
	</script>

	<style>
		:scope {
			display: block;
			background: #cddc39;
			padding: 15px;
			margin-top: 15px;
		}
	</style>

</demo-child>
