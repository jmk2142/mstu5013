<app>

	<h1 hide={ currentStory }>Choose your own adventure:</h1>

	<button type="button" hide={ editor || currentStory } onclick={ openEditor }>NEW STORY</button>

	<div class="editor" show={ editor }>
		<p>EDITOR</p>
		<input ref="title" type="text" placeholder="Enter Title">
		<input ref="author" type="text" placeholder="Enter Pen Name" onkeyup={ createStory }>
		<button onclick={ createStory }>SAVE</button>
		<button onclick={ closeEditor }>CANCEL</button>
	</div>

	<story if={ !currentStory } each={ story in stories }></story>

	<reader if={ currentStory } story={ currentStory }></reader>

	<script>
		var tag = this;

		this.editor = false;
		this.currentStory = null;
		this.stories = [];

		storiesRef.on('value', function(snap){
			var data = snap.val();
			tag.stories = data && Object.values(data);
			tag.update();
		});

		observable.on('story:read', function(story) {
			tag.currentStory = story;
			tag.update();
		});

		observable.on('story:exit', function() {
			tag.currentStory = null;
			tag.update();
		});

		// EDITOR
		openEditor(e) {
			this.editor = true;
		}
		closeEditor(e) {
			this.editor = false;
		}
		createStory(e) {
			if (e.type === 'keyup' && e.code != 'Enter') {
				return;
			}
			if (!this.refs.title.value || !this.refs.author.value) {
				alert('You must enter a title and author.');
				return;
			}

			var key = storiesRef.push().key;
			var sceneKey = rootRef.child('scenesByStory/' + key).push().key;

			var story = {
				title: this.refs.title.value,
				author: this.refs.author.value,
				id: key,
				startSceneID: sceneKey
			};


			var firstScene = {
				content: "Your adventure begins here...",
				storyID: key,
				id: sceneKey,
				parentSceneID: '', // firstScene never has a parentScene
				scenePrompts: {}
			};

			var locations = {};
				locations['stories/' + key] = story;
				locations['scenesByStory/' + key + '/' + sceneKey] = firstScene;

			rootRef.update(locations).then(function(){
			  tag.reset();
			});
		}
		reset(e) {
			this.refs.title.value = "";
			this.refs.author.value = "";
			this.closeEditor();
			this.update();
		}
	</script>

	<style>
		:scope {
			display: block;
			font-family: 'Courier New';
			font-weight: 200;
		}
		.editor {
			background-color: #DDD;
			padding: 1em;
		}
	</style>
</app>
