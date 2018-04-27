<story>

	<h2>{ story.title }</h2>
	<p>By { story.author }</p>

	<button onclick={ readStory }>READ</button>
	<button onclick={ deleteStory } ref="deleteBtn">DELETE</button>

	<script>
		var that = this;
		var storyRef = storiesRef.child(this.story.id);

		deleteStory(e) {
			var locations = {};
					locations['stories/' + this.story.id] = null;
					locations['scenesByStory/' + this.story.id] = null;

			rootRef.update(locations);
		}
		readStory(e) {
			observable.trigger('story:read', this.story);
		}

	</script>

	<style>
		:scope {
			display: block;
			border: 1px solid #333;
			padding: 1em;
		}
		:scope:not(:last-of-type) {
			border-bottom-width: 0px;
		}
		:scope:first-of-type {
			margin-top: 1em;
		}
		button {
			cursor: pointer;
			transition: all 0.25s ease-in-out;
		}
		[ref="deleteBtn"]:hover {
			color: white;
			background-color: #ca0000;
		}
	</style>
</story>
