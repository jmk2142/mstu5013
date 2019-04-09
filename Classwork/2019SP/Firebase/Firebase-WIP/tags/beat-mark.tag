<beat-mark>
  <!-- HTML -->
  <div class={ 'beat-mark':true, beatMarker:emphasize, barEnd:lastBeat } onclick={ markNote }>
		{ i + 1 }
  </div>

  <script>
    // JAVASCRIPT
    this.beatCount = opts.beatCount;
		this.emphasize = false;
		this.lastBeat = (() => (this.i + 1) % 4 === 0)();
		this.beat = 0;
		this.person = opts.person;

		let roomRef;

		// console.log(this);

		markNote(event) {
			console.log('MARK NOTE', event.item);
			let note = event.item.note;

			note.duration = 500;
			note.pitch = 200;
			note.sound = "oscillator";
			console.log('xxx', this.person);
			observer.trigger('noteMarked', this.person);
		}

		observer.on('onBeat', index => {
			this.beat = index;


			if (this.i === index) {
				this.emphasize = true;
			} else {
				this.emphasize = false;
			}
			this.update();
		});

		observer.on('stopBeat', () => {
			this.emphasize = false;
			this.update();
		})

		this.on('update', () => {
			console.log('beat-mark update');
			if (opts.room) {
				this.room = opts.room;
				roomRef = database.collection('sound-rooms').doc(this.room.id);
			}
			if (opts.person) {
				this.person = opts.person;
			}
			console.log('update', this);
		});
  </script>

  <style>
    /* CSS */
    :scope {
    	line-height: 2em;
    	text-align: center;
    }
		.beat-mark {
			display: inline-block;
			width: 2em;
			height: 2em;
			background-color: pink;
			margin-right: 1em;
			cursor: pointer;
		}
		.beatMarker {
			background-color: orange;
		}
		.barEnd {
			outline: 2px solid grey;
		}
  </style>
</beat-mark>
