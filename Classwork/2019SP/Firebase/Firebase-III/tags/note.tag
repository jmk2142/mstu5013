<note>

	<div class="note { toggledOn:note.play } { cue:cue }" onclick={ toggleNote }></div>

	<script>
		this.room = opts.room;
		this.isUser = opts.isUser;
		this.roomUser = opts.roomUser;
		this.cue = false;

		toggleNote(event) {
			if (this.isUser) {
				let roomUserDoc = database.collection('sound-rooms/' + this.room.id + '/users').doc(this.roomUser.id);
				this.roomUser.notes[this.i].play = !this.roomUser.notes[this.i].play;
				roomUserDoc.update(this.roomUser);
			}
		}
		observer.on('onBeat', beatIndex => {
			console.log('x')
			if (this.i === beatIndex) {
				this.cue = true;
			} else {
				this.cue = false;
			}
			this.update();
		})

		this.on('update', () => {
			this.isUser = opts.isUser;
			this.room = opts.room;
			this.roomUser = opts.roomUser;
		});
	</script>

	<style>
		.note {
			display: inline-block;
			width: 2em;
			height: 2em;
			background-color: silver;
			margin-right: 0.25em;
		}
		.toggledOn {
			background-color: orange;
		}
		.cue {
			outline: 2px solid turquoise;
		}
	</style>
</note>
