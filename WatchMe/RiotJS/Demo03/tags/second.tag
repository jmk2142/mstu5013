<second>
	<strong>second.tag</strong>

	<button type="button" onclick={ unmountSecond }>Unmount Second</button>

	<button type="button" onclick={ getDataFromDatabase }>Get DATA</button>

	<pre>data = { username }</pre>

	<script>
		var that = this;

		console.log('second.tag');

		this.username = "no name";

		this.getDataFromDatabase = function(event) {
			event.preventUpdate = true;
			
			var data = "xyz";

			setTimeout(function(){
			  data = "jmk2142";
				that.username = data;
				that.update();
			}, 3000);
		};

		this.on('update', function(event){
		  console.log('this.username', this.username);
		});



		// this.unmountSecond = function(event) {
		//   this.unmount();
		// };

		// this.on('mount', function(event){
		//   console.log('MOUNT second.tag');
		// });
		//
		// this.on('unmount', function(event){
		//   console.log('UNMOUNT second.tag');
		// });
	</script>

	<style>
		:scope {
			display: block;
		}
	</style>
</second>
