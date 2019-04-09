<sound-room>
  <!-- HTML -->
  <h2>Sound Room: { room.id }</h2>
	<p><span each={ person, i in people }>{ person.name }{ i < people.length - 1 ? "," : "" } </span></p>

	<button class="btn btn-warning" onclick={ exitRoom }>EXIT</button>
	<button if={ room.owner === user.uid } class="btn btn-danger" onclick={ deleteRoom }>DELETE</button>

	<div class="metronome">
		<beat-mark class="beat-{i}" each={ beat, i in beats }></beat-mark>
		<button class="btn btn-success" ref="start" onclick={ startMetronome } disabled={ playing }>START</button>
		<button class="btn btn-secondary" ref="stop" onclick={ stopMetronome } disabled={ !playing }>STOP</button>
	</div>

	<div class="userNotes">
		<div class="user" each={ person in people }>
			<p>{ person.name } &mdash; { person.id }</p>

			<beat-mark class="beat-{i}" each={ note, i in person.notes } person={ person } room={ room }></beat-mark>
		</div>
	</div>


  <script>
    // JAVASCRIPT
    this.room = opts.room;
		this.user = opts.user;
		this.people = opts.people;

		console.log(this.people);

		this.beats = new Array(16);

		observer.on('noteMarked', person => {
			console.log('noteMarked');
			console.log(this.people);
			let targetPerson = this.people.find(user => person.id === user.id);
			console.log(targetPerson);
		})

		const SOUNDS = [
			"snareA.wav",
			"snareB.wav",
			"get-outta-here.mp3",
			"credulous.mp3",
			"glass-breaking.mp3",
			"just-like-magic.mp3",
			"filling-your-inbox.mp3",
			"oringz-w468.mp3"
		];

		let audio = [];
		for (sound of SOUNDS) {
			audio.push(new Audio("./sounds/" + sound));
		}

		const BEAT = 500; // ms
		const BAR = 2000; // ms

		let beatA = new Audio('./sounds/snareA.wav');
		let beatB = new Audio('./sounds/snareB.wav');

		this.beat = 0;
		this.beatCount = 0;

		let metronome;

		metroSound() {
			let rand = Math.floor(Math.random() * audio.length);
			let tick = audio[rand];

			tick.play();

			if (this.beatCount === 3) {
				beatB.play();
			}

			observer.trigger('onBeat', this.beat);

			if (this.beatCount < 3) {
				this.beatCount++;
			} else {
				this.beatCount = 0;
			}
			if (this.beat < 15) {
				this.beat++;
			} else {
				this.beat = 0;
			}
		}

		let roomRef = database.collection('sound-rooms').doc(this.room.id);

		startMetronome() {
			metronome = setInterval(this.metroSound, BEAT);
			this.playing = true;
		}
		stopMetronome() {
			clearInterval(metronome);
			this.beatCount = 0;
			this.beat = 0;
			this.playing = false;
			// observer.trigger('stopBeat');
		}


		// create web audio api context
		// var audioCtx = new (window.AudioContext || window.webkitAudioContext)();
		//
		// // create Oscillator node
		// var oscillator = audioCtx.createOscillator();
		//
		// oscillator.type = 'square';
		// oscillator.frequency.setValueAtTime(440, audioCtx.currentTime); // value in hertz
		// oscillator.connect(audioCtx.destination);
		// // oscillator.start();


		exitRoom() {
			let updates = {};
					updates["people." + this.user.uid] = firebase.firestore.FieldValue.delete();
					roomRef.update(updates);

			this.parent.room = null;
			this.parent.update();
		}
		deleteRoom() {
			roomRef.delete();
		}

		this.on('update', () => {
			this.people = opts.people;
		})
  </script>

  <style>
    /* CSS */
    :scope {
    	display: block;
			margin-top: 2em;
    }
		.instruments {
			margin-top: 1em;
		}
		.mark {
			background-color: orange;
		}
		.metronome, .user {
			border: 1px solid grey;
			margin: 1em 0;
			padding: 1em;
		}

  </style>
</sound-room>
