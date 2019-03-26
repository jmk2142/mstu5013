<app>

	<h3>{ opts.title }</h3>

	<ul>
		<li each={ todo in items.filter(whatShow) }>
			<label class={ completed: todo.done }>
				<input type="checkbox" checked={ todo.done } onclick={ parent.toggle }>
				{ todo.title }
			</label>
		</li>
	</ul>

	<form onsubmit={ add }>
		<input ref="input" onkeyup={ edit }>
		<button disabled={ !text }>Add #{ items.filter(whatShow).length + 1 }</button>

		<button type="button" disabled={ items.filter(onlyDone).length == 0 } onclick={ removeAllDone }>
			X{ items.filter(onlyDone).length }
		</button>
	</form>

	<!-- this script tag is optional -->
	<script>
		this.items = opts.items;

		edit(event) {
			this.text = event.target.value;
		}

		add(event) {
			if (this.text) {
				this.items.push({title: this.text});
				this.text = this.refs.input.value = '';
			}
			event.preventDefault();
		}

		removeAllDone(event) {
			this.items = this.items.filter(function (item) {
				return !item.done;
			});
		}

		// an two example how to filter items on the list
		whatShow(item) {
			return !item.hidden;
		}

		onlyDone(item) {
			return item.done;
		}

		toggle(event) {
			var item = event.item.todo;
			item.done = !item.done;
			return true;
		}
	</script>

</app>
