<app>
  <!-- HTML -->
  <h1>TODO</h1>

	<ul>
		<todo-item each={ todo, i in todos }></todo-item>
		<li show={ todos.length === 0 }>No TODOs</li>
	</ul>

	<todo-editor todos={ todos }></todo-editor>

  <script>
    // JAVASCRIPT
    let tag = this;

		this.todos = [{
			task: "Wake Up",
			done: false
		},{
			task: "Go to School",
			done: true
		},{
			task: "Sleep",
			done: false
		}];

		observer.on('todo:add', (todoText) => {
			this.todos.push({
				task: todoText,
				done: false
			});
			this.update();
		});

		observer.on('todo:remove', () => {
			this.todos = this.todos.filter(todoItem => !todoItem.done);
			this.update();
		});

  </script>

  <style>
    /* CSS */
    :scope {}
		li {
			font-style: italic;
		}
  </style>
</app>
