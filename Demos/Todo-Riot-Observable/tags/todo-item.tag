<todo-item>
  <!-- HTML -->
	<label>
		<input type="checkbox" onclick={ toggle } checked={ todo.done }>
		<span class={ done:todo.done }>{ todo.task }</span>
	</label>

  <script>
    // JAVASCRIPT
    let tag = this;

		toggle(event) {
			this.todo.done = !this.todo.done;
			observer.trigger('todo:removeQueued');
		}

  </script>

  <style>
    /* CSS */
    :scope {
    	display: list-item;
    }
		label {
			padding: 1em;
			border-radius: 0.25em;
			cursor: pointer;
			transition: all 0.25s ease-in-out;
		}
		label:hover {
			background-color: #ff9800;
		}
		.done {
			text-decoration: line-through;
			font-style: italic;
		}
  </style>
</todo-item>
