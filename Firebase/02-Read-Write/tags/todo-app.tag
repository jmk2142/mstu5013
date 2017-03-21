<todo-app>
	<h1>TODO APP <small>Firebase Demonstration</small></h1>

	<div class="row">
		<div class="col-md-4 col-md-offset-4">
			<h2 class="page-header">LIST</h2>

			<todo-item each={ todosData }></todo-item>

			<div class="form-group">
				<input class="form-control" type="text" placeholder="Enter todo task" onkeypress={ addItem }>
			</div>

			<div class="form-group">
				<button class="btn btn-danger" disabled={ todosData.filter(onlyDone).length == 0 } onclick={ removeItems }>
					<i class="fa fa-trash"></i> { todosData.filter(onlyDone).length }
				</button>
			</div>

		</div>
	</div>

	<script>
		var that = this;

		/* ----------------------------------------
			Play, Observe, Tinker, Articulate

			0) Replace my firebase keys with yours in index.html

			1) By manipulating the firebase data viewer, trigger the 'value', 'child_added', 'child_removed' events. Articulate what the causal events of what you did and how this program reacts. Explain what you think is going on. You'll have to comment/remove comment to test each individually.

			2) What is the difference between the snapshot from the 'value', 'child_added', and 'child_removed' event?

			3) Concept to Code -> a) If I "check" a todo item, then press the trash button, how does the program "know" which todo items to get rid of? b) Look at the firebase data viewer, how might firebase "know" which data we need to get rid of? (Can this currently be done? Why or why not?)

			4) Articulate the concept of how the program should remove the items from the database. Try to make the trash button actually work.

			5) What if we wanted this program to consider the user and their specific todos?

			OPTIONAL
			6) Underscore or LoDash Library
		---------------------------------------- */

		// To be poplated by data from Firebase
		this.todosData = [];

		// First thing we want to do is read the data on the tag load.
		var database = firebase.database();
		var todoItemsRef = database.ref('todoItems');

		/*
			Getting all todos with the 'value' event
			snapshot is an object with all todo items
			each property of the snapshot is the todo data
		*/

		todoItemsRef.on('value', function(snapshot) {
			console.log('"value" snapshot.val()', snapshot.val());
			var data = snapshot.val(); // Object with properties as keys

			var todos = [];

			for (var key in data) {
				todos.push(data[key]);
			}

			that.todosData = todos;
			console.log('this.todosData', that.todosData);
			that.update();
		});


		/*
			Getting all todos with the 'child_added' event
			What is the difference between this snapshot and the
			snapshot from 'value' above?
		*/

		// todoItemsRef.on('child_added', function(snapshot) {
		// 	console.log('"child_added" snapshot.val()', snapshot.val());
		//
		// 	var data = snapshot.val(); // Object with properties as keys
		// 	that.todosData.push(data);
		//
		// 	console.log('this.todosData', that.todosData);
		// 	that.update();
		// });

		// todoItemsRef.on('child_removed', function(snapshot) {
		// 	console.log('"child_removed" snapshot.val()', snapshot.val());
		//
		// 	var data = snapshot.val();
		// 	var key = snapshot.key;
		//
		// 	var targetTodo;
		//
		// 	for (var i = 0; i < that.todosData.length; i++) {
		// 		if (that.todosData[i].id === key) {
		// 			targetTodo = that.todosData[i];
		// 			break;
		// 		}
		// 	}
		//
		// 	var index = that.todosData.indexOf(targetTodo);
		// 	that.todosData.splice(index, 1);
		//
		// 	console.log(that.todosData);
		// 	that.update();
		// });


		addItem(event){
			var newTask = {};
			if (event.which === 13) {
				newTask.task = event.target.value;
				newTask.done = false;

				var newKey = todoItemsRef.push().key;

				todoItemsRef.child(newKey).set(newTask);

				event.target.value = "";	// RESET INPUT
				event.target.focus();			// FOCUS BACK ON INPUT
			}
		}

		removeItems(event) {
			// HINT for question below:
			var rejectedData = this.todosData.filter(function(item){
				return item.done;
			});
			console.log('rejectedData', rejectedData);

			// Question: What does this statement do?
			this.todosData = this.todosData.filter(function(item) {
        return !item.done;
      });

			console.log('this.todosData', this.todosData);

			// HINT for removing on firebase
			// REFERENCE.remove();
			// REFERENCE.set(null);
		}

		// Iterator function for the Array.filter(iterator) method...
		onlyDone(item) {
			return item.done === true;
		}
	</script>

	<style>
		:scope {
			display: block;
		}
	</style>
</todo-app>
