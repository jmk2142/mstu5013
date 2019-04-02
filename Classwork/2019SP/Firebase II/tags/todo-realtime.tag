<todo-realtime>

	<h3>{ title } &mdash; Realtime</h3>

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
		this.title = opts.title || "DEFAULT TITLE";
		this.items = opts.items || [];

		edit(event) {
			this.text = event.target.value;
		}

		add(event) {
			if (this.text) {

				// DATABASE WRITE - Preparation
				let collectionRef = database.collection('todos-live');
				let docRef = collectionRef.doc();
				let id = docRef.id;

				// DATABASE WRITE
				collectionRef.doc(id).set({
					title: this.text,
					done: false,
					id: id
				});

				this.text = this.refs.input.value = '';
			}
			event.preventDefault();
		}

		removeAllDone(event) {
			let doneItems = this.items.filter(todo => todo.done);

			for (doneTodo of doneItems) {
				// DATABASE DELETE
				database.collection('todos-live').doc(doneTodo.id).delete();
			}
		}

		toggle(event) {
			let item = event.item.todo;
			item.done = !item.done;
			return true;
		}

		// FILTER FUNCTIONS ----------------------------------------

		whatShow(item) {
			return !item.hidden;
		}

		onlyDone(item) {
			return item.done;
		}

		// LIFECYCLE EVENTS ---------------------------------------

		let stopListening;

		this.on('mount', () => {
			// DATABASE READ LIVE
			stopListening = database.collection('todos-live').onSnapshot(snapshot => {
				this.items = snapshot.docs.map(doc => doc.data());
				this.update();
			});
		});

		this.on('unmount', () => {
			stopListening();
		});
	</script>

</todo-realtime>
