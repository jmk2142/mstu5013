<scene-editor>

	<p>SCENE EDITOR</p>

	<div class="previousScene" if={ prevScene.content }>
		<h6>PREVIOUSLY:</h6>
		<p>{ prevScene.content }</p>
		<h6>PROMPT CHOSEN:</h6>
		<p>{ prevScene.scenePrompts[scene.id] }</p>
	</div>

	<textarea ref="sceneContent" rows="5" placeholder="Enter scene content." onblur={ save }>{ scene.content }</textarea>

	<ol>
		<li each={ prompt, key in scene.scenePrompts }>
			<input ref={ key } type="text" value={ prompt } onkeypress={ updatePrompt } onblur={ updatePrompt }>
		</li>
		<li>
			<input type="text" placeholder="Add Option" onkeypress={ addPrompt }>
		</li>
	</ol>

	<button onclick={ save }>SAVE SCENE</button>
	<button onclick={ cancel }>EXIT EDITOR</button>

	<script>
		var tag = this;
		this.scene = this.opts.scene;
		this.prevScene = this.opts.prev;

		var storyScenesRef = rootRef.child('scenesByStory/' + this.scene.storyID);
		var sceneRef = storyScenesRef.child(this.scene.id);

		addPrompt(e) {
			console.log(e.type);
			if ((e.code === 'Enter' || e.type === 'blur') && e.currentTarget.value) {
				var key = sceneRef.child('scenePrompts').push().key;

				if (!this.scene.scenePrompts) {
					this.scene.scenePrompts = {};
				}

				this.scene.scenePrompts[key] = e.currentTarget.value;

				// this.save();

				var locations = {};
				locations[this.scene.id] = this.scene;

				var scenePrompts = this.scene.scenePrompts;

				for (key in scenePrompts) {
					locations[key] = {
						content: "",
						storyID: this.scene.storyID,
						id: key,
						parentSceneID: this.scene.id,
						scenePrompts: {}
					}
				}

				storyScenesRef.update(locations);

				e.currentTarget.value = "";
			}
		}
		updatePrompt(e) {
			if ((e.code === 'Enter' || e.type === 'blur') && e.currentTarget.value) {
				var key = e.currentTarget.getAttribute('ref');
				var prompt = e.currentTarget.value;

				this.scene.scenePrompts[key] = prompt;

				this.save();
				e.currentTarget.blur();
			}
		}

		save(e) {
			this.scene.content = this.refs.sceneContent.value;
			sceneRef.update(this.scene);

			console.log('SAVED SCENE');
		}
		cancel(e) {
			observable.trigger('sceneEdit:cancel');
			console.log('CANCELLED SCENE');
		}

	</script>

	<style>
		:scope {
			display: block;
		}
		textarea {
			box-sizing: border-box;
			font-size: 1.5em;
			padding: 1em;
			font-family: 'Courier New';
			line-height: 1em;
			width: 100%;
		}
		input {
			font-size: 1em;
			padding: 1em;
			margin-bottom: 1em;
			width: 50%;
		}
		.previousScene {
			line-height: 1em;
			background-color: #DDD;
			padding: 0.5em;
			margin-bottom: 0.5em;
		}
		.previousScene h6 {
			margin-bottom: 1.5em;
		}
	</style>
</scene-editor>
