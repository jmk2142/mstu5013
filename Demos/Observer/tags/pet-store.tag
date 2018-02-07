<pet-store>

	<div>
		<strong>PETSTORE.TAG</strong>
		<button onclick={ resetAll }>RESET ALL</button>
	</div>
	
	<p>This demonstration shows two sibling tags, dog.tag and cat.tag.</p>
	<p>See javascript in <strong>index.html</strong> for how to create an observable object.</p>
	<p>Both dog and cat tags listen for specific and general <em>events</em> from an <em>observable</em> object.</p>
	<p>Each can make the <em>observable</em> trigger a particular event.</p>
	<p>When events are triggered, they can include <em>optional data</em> as arguments to be passed to the listener.</p>

	<dog></dog>
	<cat></cat>

	<script>
		var that = this;
		console.log('pet-store.tag');

		resetAll(event) {
			observable.trigger('reset');
		}

	</script>

	<style>
		:scope {
			display: block;
			border: 2px solid gold;
			margin-top: 1em;
			padding: 1em;
		}
	</style>
</pet-store>
