<todo-app>
	<!-- NOTE: that this is a base application for you to play with and contains zero firebase code. I will be using this exact same application in the WatchMe videos where we progressively add firebase code and build out the data integration. -->
	<h1>TODO APP <small>Firebase Demonstration</small></h1>

	<div class="row">
		<div class="col-md-4 col-md-offset-4">
			<h2 class="page-header">LIST</h2>

			<todo-item each={ fakeData }></todo-item>

			<div class="form-group">
				<input class="form-control" type="text" placeholder="Enter todo task" onkeypress={ addItem }>
			</div>

			<div class="form-group">
				<button class="btn btn-danger" disabled={ fakeData.filter(onlyDone).length == 0 } onclick={ removeItems }>
					<i class="fa fa-trash"></i> { fakeData.filter(onlyDone).length }
				</button>
			</div>

		</div>
	</div>

	<script>
		var that = this;

		// STATIC data that eventually will come from Firebase
		this.fakeData = [{
			task: "Item A",
			done: true
		},{
			task: "Item B",
			done: false
		},{
			task: "Item C",
			done: false
		}];

		// To understand the event object better see:
		// http://riotjs.com/guide/#event-handlers
		// http://riotjs.com/guide/#event-object
		addItem(event){
			var newTask = {};
			if (event.which === 13) {
				newTask.task = event.target.value;	// Grab the user task value
				newTask.done = false;

				this.fakeData.push(newTask);	// Pushes new task item to the fakeData list

				event.target.value = "";	// RESET INPUT
				event.target.focus();			// FOCUS BACK ON INPUT
			}
		}

		removeItems(event){
			this.fakeData = this.fakeData.filter(function(item) {
        return !item.done;
      });
		}

		onlyDone(item) {	// Iterator function for the Array.filter(iterator) method...
			return item.done === true;
		}
	</script>

	<style>
		:scope {
			display: block;
		}
	</style>
</todo-app>
