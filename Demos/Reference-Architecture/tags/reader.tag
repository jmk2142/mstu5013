<reader>

	<h1>
		{ story.title } <small>By { story.author }</small>
		<button onclick={ exitReader }>EXIT</button>
	</h1>

	<div class="scene" if={ !sceneEditor }>
		<div class="content" if={ scene.content }>
			<p each={ line in scene.content.split('\n') }>{ line }</p>
		</div>

		<p hide={ scene.content }>No scene content...</p>

		<p show={ scene.scenePrompts }><strong>CHOOSE BELOW:</strong></p>
		<ol>
			<li ref={ key } each={ prompt, key in scene.scenePrompts } onclick={ loadScene }>{ prompt }</li>
		</ol>

		<button onclick={ prevScene } show={ scene.parentSceneID }>BACK</button>
		<button onclick={ showEditor }>EDIT SCENE</button>
	</div>

	<scene-editor if={ sceneEditor } scene={ scene } prev={ parentScene }></scene-editor>

	<script>
		var tag = this;
		this.story = this.opts.story;
		this.parentScene = {};
		this.scene = {};
		this.sceneEditor = false;

		var storyScenesRef = rootRef.child(`scenesByStory/${this.story.id}`);

		prevScene(e) {
			console.log(this);
			var key = this.scene.parentSceneID;
			this.getScene(key);
		}

		loadScene(e) {
			var key = e.currentTarget.getAttribute('ref');
			this.getScene(key);
		}

		getScene(id) {
			var sceneRef = storyScenesRef.child(id);

			sceneRef.once('value').then(function(snap){
				tag.parentScene = tag.scene;

			  var scene = snap.val();
				tag.scene = scene;

				tag.update();
			});
		}

		showEditor(e) {
			this.sceneEditor = true;
			this.update();
		}

		exitReader(e) {
			observable.trigger('story:exit');
		}

		this.on('mount', function(){
		  this.getScene(this.story.startSceneID);
		});

		observable.on('sceneEdit:cancel', function() {
			tag.sceneEditor = false;
			tag.update();
		});

	</script>

	<style>
		:scope {
			display: block;
		}
		small {
			color: silver;
		}
		.scene {
			font-size: 1em;
		}
		li {
			font-size: 1em;
			line-height: 1.5em;
			cursor: pointer;
		}
		li:hover {
			color: dodgerblue;
			font-weight: bold;
		}
	</style>
</reader>
