<box class="d-flex flex-column justify-content-center text-center" onclick={ markBox }>
	<div class="box-content {box-hover:preview, box-win:winBox}" onmouseenter={ hoverIn } onmouseleave={ hoverOut }>
		{ marked || preview }
	</div>

  <script>
    // JAVASCRIPT
    let tag = this;

		this.winBox = false;

		this.row = opts.rowI;
		this.col = opts.colI;
		this.boxID = "" + this.row + this.col;

		hoverIn() {
			if (!this.marked && opts.playing) {
				this.preview = opts.turn;
			}
		}
		hoverOut() {
			this.preview = "";
		}
		markBox() {
			if (opts.playing) {
				this.marked = opts.turn;
				observer.trigger('marked', this.row, this.col);
			}
		}

		observer.on('game:end', (msg, winBoxIDs) => {
			if (winBoxIDs.includes(this.boxID)) {
				this.winBox = true;
			}
		});
  </script>

  <style>
    /* CSS */
    :scope {
    	width: 1.5em;
			height: 1.5em;
			background-color: #6c757d;
			font-size: 5em;
			cursor: pointer;
			margin: 0.05em;
    }
		.box-hover {
			background-color: #ffc107;
		}
		.box-content {
			width: 100%;
			height: 100%;
		}
		.box-win {
			background-color: #28a745;
		}
  </style>
</box>
