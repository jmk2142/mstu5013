<number>

	<label>
		<input type="radio" name={ id } value={ num }>
		<div class="numContainer" style={ myStyles }>
			<div class="numContent" style="font-size:{getSize(num, numRef)}em">
				{ num }
			</div>
			<p>NUMBER TAG<br>maxSize: { numRef[9].size }</p>
		</div>
	</label>

	<script>
		var that = this;

		this.id = this.opts.numId;
		this.numRef = this.opts.numRef;
		this.boxSize = this.opts.boxSize;

		this.myStyles = {
			"width": this.boxSize + "em",
			"height": this.boxSize + "em",
			"line-height": this.boxSize + "em"
		};

		this.on('update', function(){

			this.id = this.opts.numId;
			this.numRef = this.opts.numRef;
			this.boxSize = this.opts.boxSize;

			this.myStyles = {
				"width": this.boxSize + "em",
				"height": this.boxSize + "em",
				"line-height": this.boxSize + "em"
			};

			console.log('number update');
		});

	</script>

	<style>
		:scope {
			display: inline-block;
			margin-right: 0.5em;
			vertical-align: middle;
		}
		.numContainer {
			display: inline-block;
			text-align: center;
			border: 1px solid tomato;
			vertical-align: middle;
		}
		p {
			margin-top: 4em;
			font-size: 0.25em;
			line-height: 1em;
		}
	</style>
</number>
