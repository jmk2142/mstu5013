<metronome>
	<button disabled={ playing } class="btn btn-success" type="button" onclick={ startMetronome }>START</button>
	<button class="btn btn-danger" type="button" onclick={ stopMetronome }>STOP</button>

	<script>
		const BEAT = 500;
		let metronome;
		let beatA = new Audio('./sounds/snareA.wav');
		let beatB = new Audio('./sounds/snareB.wav');

		this.playing = false;
		this.beatIndex = 0;
		this.beatCount = 0;

		metroSound() {
			beatA.play();

			if (this.beatCount === 3) {
				beatB.play();
			}

			observer.trigger('onBeat', this.beatIndex);

			if (this.beatCount < 3) {
				this.beatCount++;
			} else {
				this.beatCount = 0;
			}
			if (this.beatIndex < 15) {
				this.beatIndex++;
			} else {
				this.beatIndex = 0;
			}
		}

		startMetronome() {
			metronome = setInterval(this.metroSound, BEAT);
			this.playing = true;
		}
		stopMetronome() {
			clearInterval(metronome);
			this.beatCount = 0;
			this.beat = 0;
			this.playing = false;
		}
	</script>

	<style>
		:scope {
			display: block;
		}
	</style>
</metronome>
