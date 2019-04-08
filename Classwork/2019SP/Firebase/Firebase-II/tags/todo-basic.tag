<todo-basic>

	<h3>{ title } &mdash; Basic</h3>

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

	<button type="button" onclick={ nextPage }>NEXT PAGE</button>

	<!-- this script tag is optional -->
	<script>
		this.title = opts.title || "DEFAULT TITLE";
		this.items = opts.items || [];

		edit(event) {
			this.text = event.target.value;
		}

		add(event) {
			if (this.text) {

				let todo = {
					title: this.text,
					done: false,
					timestamp: firebase.firestore.FieldValue.serverTimestamp()
				};

				// DATABASE WRITE
				database.collection('todos').add(todo).then(doc => {
					console.log('Document successfully created!');

					todo.id = doc.id;
					this.items.push(todo);

					this.update();
				});

				this.text = this.refs.input.value = '';
			}

			event.preventDefault();
		}

		removeAllDone(event) {
			let doneTodos = this.items.filter(item => item.done);

			let todosRef = database.collection('todos');

			for (todo of doneTodos) {

				// DATABASE DELETE
				todosRef.doc(todo.id).delete().then( () => {
					console.log('Document successfully deleted!');
				});
			}

			this.items = this.items.filter(item => !item.done);
		}

		toggle(event) {
			let item = event.item.todo;
			item.done = !item.done;

			database.collection('todos').doc(item.id).update({
				done: item.done
			});

			return true;
		}

		nextPage() {
			console.log(this.lastTimestamp);

			database.collection('todos').orderBy('timestamp','asc')
			.startAfter(this.lastTimestamp).limit(5).get().then(snapshot => {
				this.items = [];
				snapshot.forEach(doc => {
					this.items.push(doc.data());
				});

				this.lastTimestamp = this.items[this.items.length - 1].timestamp;
				this.update();
			});
		}

		// FILTER FUNCTIONS ----------------------------------------

		whatShow(item) {
			return !item.hidden;
		}

		onlyDone(item) {
			return item.done;
		}

		// LIFECYCLE EVENTS ---------------------------------------

		this.on('mount', () => {

			// DATABASE READ
			// .orderBy(prop, 'asc/desc')
			// .where('prop', '< <= == > >= array_contains', 'value')
			// .where('title', '>=', 'cam').where('title', '<', 'can')
			// .limit(number)
			// How would you get all words like camel, camera, camp?

			// https://firebase.google.com/docs/firestore/query-data/query-cursorss
			database.collection('todos')
				.orderBy('timestamp','asc').limit(3).get().then(snapshot => {
					console.log('Collection successfully fetched.');

					this.items = [];

					snapshot.forEach(doc => {
						let todo = doc.data();
								todo.id = doc.id;
						this.items.push(todo);
					});

					this.lastTimestamp = this.items[this.items.length - 1].timestamp;
					console.log(this.items);

					this.update();
			});
		});
	</script>

</todo-basic>
