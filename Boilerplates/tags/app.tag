<app>
	<div class="container">
		<div class="row">
			<div class="col s12">

				<div class="section">
					<h1>Boilerplate</h1>
				</div>
				<div class="divider"></div>
				<div class="section">
					<pre ref="dataJSON">{ json }</pre>
				</div>
				<div class="section">
					<button class="btn waves-effect waves-light" onclick={ setData }>SET</button>
					<button class="btn waves-effect waves-light" onclick={ updateData }>UPDATE</button>
					<button class="btn waves-effect waves-light" onclick={ removeData }>REMOVE</button>
				</div>
			</div>
		</div>


	</div>

	<script>
		var that = this;
		console.log('app.tag');

		var database = firebase.database();

		var motorcycleRef = database.ref('motorcycles');

		this.data = null;

		motorcycleRef.on('child_added', function(snap){
		  that.data = snap.val(); // Note: 'child_added' event returns a single data object
			that.json = JSON.stringify(that.data, null, 2);
			that.update();
		});

		setData(event){

			this.data = {
				brand: "Honda",
				name: "Grom",
				ccs: 150,
				color: "red",
				price: 4000,
				current: true
			};

			var key = motorcycleRef.push().key;
			this.data.id = key;
			motorcycleRef.child(key).set(this.data);
		}

		updateData(event){
			var updates = {};

			updates['newBikes/' + this.data.id] = this.data;
			updates['x/y/z/' + this.data.id] = this.data;
			updates[this.data.id + '/color'] = "blue";
			updates[this.data.id + '/price'] = Math.floor(Math.random() * 10000);

			motorcycleRef.update(updates);
		}

		removeData(event){
			var updates = {};

			updates['newBikes/' + this.data.id] = null;
			updates['x/y/z/' + this.data.id] = null;
			updates[this.data.id + '/color'] = null;
			updates[this.data.id + '/price'] = null;

			motorcycleRef.update(updates);
		}



	</script>

	<style>
		:scope {
			display: block;
		}
	</style>
</app>
