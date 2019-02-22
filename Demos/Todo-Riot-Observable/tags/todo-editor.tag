<todo-editor>
  <!-- HTML -->
	<div>
		<input type="text" ref="todoInput" placeholder="Add todo" onkeypress={ onEnter }>
		<button onclick={ addTodo }>ADD</button>
		<button onclick={ removeTodos } disabled={ doneTodos === 0 }>REMOVE { doneTodos || "" }</button>
	</div>

  <script>
    // JAVASCRIPT
    let tag = this;

		this.doneTodos = getDoneCount(opts.todos);

		onEnter(event) {
			if (event.code === "Enter") {
				this.addTodo();
			}
		}

		addTodo() {
			let todoText = this.refs.todoInput.value;
			observer.trigger('todo:add', todoText);
			this.refs.todoInput.value = "";
		}

		removeTodos(event) {
			observer.trigger('todo:remove');
			this.doneTodos = getDoneCount(opts.todos);
		}

		function getDoneCount(todos) {
			return todos.filter(todo => todo.done).length;
		}

		observer.on('todo:removeQueued', () => {
			this.doneTodos = getDoneCount(opts.todos);
			this.update();
		});

  </script>

  <style>
    /* CSS */
    :scope {
    	display: block;
			padding: 1em;
			border: 1px solid grey;
    }
  </style>
</todo-editor>
