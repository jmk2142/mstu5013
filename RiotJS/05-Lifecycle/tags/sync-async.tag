<sync-async>
	<strong>sync-async.tag</strong>

	<ul>
		<li>
			Synchronous - Demo: Updated is <strong>{ syncUpdated ? "YES" : "NO" }</strong>
			<button onclick={ runSync }>Update Data</button>
		</li>
		<li>
			Asynchronous - Demo: Updated is <strong>{ asyncUpdated ? "YES" : "NO" }</strong>
			<button onclick={ runAsync }>Update Data</button>
		</li>
		<li>
			Asynchronous <em>Followup</em> - Demo: Updated is <strong>{ followUpdated ? "YES" : "NO" }</strong>
			<button onclick={ runFollowup }>Update Data</button>
		</li>
	</ul>

	<script>
		var that = this;

		this.syncUpdated = false;
		this.asyncUpdated = false;
		this.followUpdated = false;

		this.runSync = function(event){
		  console.log('START Synchronous ----------');
			this.syncUpdated = true;

			this.checkValues();

			console.log('---------- END Synchronous\n\n');
		};

		this.runAsync = function(event){
		  console.log('START Asyncronous ----------');

			// setTimeout delays the execution of the callback by 500ms
			// This is similar to a network call - you can make a request to a website
			// and it takes time before the response happens.
			setTimeout(function() {
				that.asyncUpdated = true;
				that.checkValues();
			}, 500);

			console.log('---------- END Asyncronous\n\n');
		};

		this.runFollowup = function(event){
			console.log('START Asyncronous & Followup Update ----------');

			setTimeout(function() {
				that.followUpdated = true;
				that.checkValues();

				// Why, how is this line different than the runAsync() function?
				that.update();

			}, 500);

			console.log('---------- END Asyncronous & Followup Update\n\n');
		};

		this.checkValues = function(event) {
			console.log('\n')
		  console.log('this.syncUpdated', this.syncUpdated);
			console.log('this.asyncUpdated', this.asyncUpdated);
			console.log('this.followUpdated', this.followUpdated);
			console.log('\n')
		};

		// Listen for the UPDATE lifecycle
		this.on('update', function(event) {
		  console.log('sync-async.tag ---------- UPDATE');
		});

	</script>

	<style>
		:scope {
			display: block;
			background: #ff9800;
			padding: 15px;
		}
		li {
			margin-bottom: 15px;
			font-family: monospace;
			background-color: #ffeb3b;
			padding: 10px;
		}

	</style>
</sync-async>
