<parent-child-example>
	<strong>parent-child-example.tag</strong>
	<p>Like demonstrated in the prior example, looping through array of objects will give us new tag instances that represent each object in the array. These new contexts attach each object element in the child tag. Thus allowing the object.properties to be accessed via childTag.properties.</p>
	<p>An important understanding is that all the parent tag's properties are also inherited by the children tags. This includes state data as well as functions.</p>
	<p>Another important note is that each child tag will have a special property called `parent` that refers to the parent tag. Our array, the source of truth data is in the parent tag. In a "react" type UI update flow, we do not remove HTML directly. We remove the data and the UI updates as a reaction to that data change. Notice that for our button, we call the remove function on the parent <code>parent.remove</code> that is defined here in this parent tag.</p>

	<div class="bookMaker">
		<!-- ref or reference attribute is a quick way to "bookmark" an element so we can quickly access it in javascript later. -->
		<!-- E.g. HTML <img ref="xxx"/>  -->
		<!-- E.g. JS   this.refs.xxx points to the img tag prior -->
		<input type="text" ref="titleEl" placeholder="Enter title">
		<input type="text" ref="authorEl" placeholder="Enter author">
		<button type="button" onclick={ addBook }>Create</button>
	</div>

	<ol>
		<div show={ myBooks.length === 0 }>
			<p>NO BOOKS IN LIBRARY</p>
		</div>
		<li each={ myBooks }>
			{ title } <em>by { author }</em>
			<button type="button" onclick={ parent.remove }>Remove Book</button>
		</li>
	</ol>

	<!-- CONSOLE DEMONSTRATION -->
	{ console.log('C - PARENT TAG:', this); }
	<virtual each={ myBooks }>
		{ console.log('C - CHILD TAG:', this); }
	</virtual>


	<script>
		this.myBooks = [{
			title: "The Unbearable Lightness of Being",
			author: "Milan Kundera"
		},{
			title: "The Complete Calvin and Hobbes",
			author: "Bill Watterson"
		},{
			title: "The Kite Runner",
			author: "Khaled Hosseini"
		}];

		this.remove = function(event) {
			// console.log('EVENT:', event);
			// console.log('EVENT.ITEM', event.item);

			// In RiotJS, event.item refers to the book object of the child tag where the click event occurred.
			var bookObj = event.item;

			var index = this.myBooks.indexOf(bookObj);
			this.myBooks.splice(index, 1);
		};

		this.addBook = function(event) {
			var title = this.refs.titleEl.value;
			var author = this.refs.authorEl.value;
			var book = {
				title: title,
				author: author
			};

			// We are adding a book object to the source of truth array.
			this.myBooks.push(book);

			// RESET INPUTS
			this.refs.titleEl.value = "";
			this.refs.authorEl.value = "";
		};


		// THIS data is garbage data, but included to show you how data associated with this parent tag, are inherited in the children. See the children tags of the each, in the console.
		this.parentTagDataA = "Data AAA";
		this.parentTagDataB = 123456;
		this.parentTagDataC = false;
		this.parentTagDataD = { atomicNumber: 96 };
		this.parentTagDataE = ["baseball", "soccer", "karate"];
		this.parentFuncA = function() {
		  alert('This is a function defined in the parent tag.');
		};
	</script>


	<style>
		:scope {
			display: block;
			background: #cddc39;
			padding: 15px;
		}
	</style>
</parent-child-example>
