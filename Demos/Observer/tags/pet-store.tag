<pet-store>

	<div>
		<strong>PETSTORE.TAG</strong>
		<button onclick={ resetAll }>RESET ALL</button>
	</div>

	<ul>
		<li>This demonstration shows two sibling tags, dog.tag and cat.tag.</li>
		<li>See javascript in <strong>index.html</strong> for how to create an observable object.</li>
		<li>Both dog and cat tags listen for specific and general <em>events</em> from an <em>observable</em> object.</li>
		<li>Each can make the <em>observable</em> trigger a particular event.</li>
		<li>When events are triggered, they can include <em>optional data</em> as arguments to be passed to the listener.</li>
	</ul>

	<dog></dog>
	<cat></cat>

	<section>
		<strong>NOTES:</strong>
		<ul>
			<li>Both tags actually aren't aware of one another.</li>
			<li>Both dog and cat "communicate" with the <em>observable</em> object in the middle.</li>
			<li>The observable object is what dispatches <em>events</em>.</li>
			<li>Both dog and cat can tell the <em>observable</em> to <em>trigger</em> an event.</li>
			<li>Both dog and cat are "listening" for specific <em>events</em> from the <em>observable</em>.</li>
			<li>When they hear an event they are listening for, they run their respective handler functions.</li>
			<li>We call this pattern <em>event aggregation</em>. The observable is an <em>event aggregator</em>.</li>
		</ul>
	</section>


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
		section {
			margin-top: 1em;
		}
		li {
			margin-bottom: 0.5em;
		}
	</style>
</pet-store>
