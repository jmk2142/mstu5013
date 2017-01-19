<demo-parent>
	<strong>demo-parent.tag</strong>
	<p>See <a href="http://riotjs.com/api/#events">Lifecycle Events</a></p>

	<button onclick={ incrementClicks }>Number of Clicks <strong>{ numClicks }</strong></button>

	<button onclick={ removeParentTag }>Remove demo-parent.tag</button>

	<demo-child each={ alphabets }></demo-child>

	<script>
		alert('demo-parent: INITIALIZED CODE');
		console.log('demo-parent: INITIALIZED CODE');

		this.numClicks = 0;

		this.alphabets = [
			{ name:"Alpha" }
		];

		this.incrementClicks = function(event) {
			console.log('--------------------\n', 'CLICKED incrementClicks');
		  this.numClicks++;
		};

		this.removeParentTag = function(event) {
			console.log('--------------------\n', 'CLICKED removeParentTag');
		  this.unmount();
		};

		var that = this; // What do you think is the purpose here?
		this.removeChildTag = function(event) {
			console.log('--------------------\n', 'CLICKED removeChildTag');

		  var childAlphabet = event.item;

			var index = that.alphabets.indexOf(childAlphabet); // and here?
			that.alphabets.splice(index, 1); // and here?

			that.update();
		};

		// NOTICE THESE ARE THE LIFECYCLE EVENTS ---
		// These are event listeners that listen for Riot specific events.
		// The first argument is the event type String.
		// The second argument is a callback/handler function.
		// Pay attention to the order and when these are triggered.
		this.on('before-mount', function(event) {
			alert('demo-parent.tag before-mount');
			console.log('demo-parent.tag before-mount');
		});

		this.on('mount', function(event) {
		  alert('demo-parent.tag mount');
			console.log('demo-parent.tag mount');
		});

		this.on('update', function(event) {
		  alert('demo-parent.tag update');
			console.log('demo-parent.tag update');
		});

		this.on('updated', function(event) {
		  alert('demo-parent.tag updated');
			console.log('demo-parent.tag updated');
		});

		this.on('before-unmount', function(event) {
		  alert('demo-parent.tag before-unmount');
			console.log('demo-parent.tag before-unmount');
		});

		this.on('unmount', function(event) {
		  alert('demo-parent.tag unmount');
			console.log('demo-parent.tag unmount');
		});

		alert('demo-parent: LOADED CODE');
		console.log('demo-parent: LOADED CODE\n--------------------');

	</script>

	<style>
		:scope {
			display: block;
			background: #607d8b;
			padding: 15px;
		}
	</style>

</demo-parent>
