<app>
  <!-- HTML -->
	<div class="card">
		<div class="card-header">
			<h3>{ message }</h3>
		</div>
		<div class="card-body">
			<div class="board">
				<p show={ neverPlayed }>Get ready to play Tic-Tac-Toe.</p>
				<div class="board-row d-flex justify-content-center" each={ row, i in board }>
					<box each={ num, i in row } row-i={ parent.i } col-i={ i } turn={ turn } board={ board } playing={ playing }></box>
				</div>
			</div>
		</div>
		<div class="card-footer">
			<button class="btn btn-primary" onclick={ newGame }>New Game</button>
		</div>
	</div>

  <script>
    // JAVASCRIPT
    let tag = this;

		this.message = "Tic-Tac-Toe";
		this.neverPlayed = true;
		this.playing = false;
		this.squaresRemaining = 9;

		newGame() {
			this.squaresRemaining = 9;
			this.turn = (Math.random() > 0.5) ? "X" : "O";
			this.message = `Player ${this.turn}'s turn...`;
			this.board = [
				[0,0,0],
				[0,0,0],
				[0,0,0]
			];
			this.playing = true;
			this.neverPlayed = false;
		}

		togglePlayer() {
			this.turn = (this.turn === "X") ? "O" : "X";
			this.message = `Player ${this.turn}'s turn...`;
		}

		checkWin(rowIndex, colIndex) {
			// Check ROW
			let rowSum = this.board[rowIndex].reduce((acc, num) => acc + num);

			// Check COL
			let colSum = this.board.map(row => row[colIndex]).reduce((acc, num) => acc + num);

			// Check DIAGONAL
			const checkDIAGONAL = ["00","02","11","20","22"];
			let diagASum, diagBSum;
			if (checkDIAGONAL.includes("" + rowIndex + colIndex)) {
				diagASum = this.board[0][0] + this.board[1][1] + this.board[2][2];
				diagBSum = this.board[0][2] + this.board[1][1] + this.board[2][0];
			}

			let win = false;
			let msg = "";
			let winBoxIDs;

			if (Math.abs(rowSum) === 3) {
				win = true;
				msg = "Win by ROW";
				winBoxIDs = [`${rowIndex}0`,`${rowIndex}1`,`${rowIndex}2`];
			} else if (Math.abs(colSum) === 3) {
				win = true;
				msg = "Win by COLUMN";
				winBoxIDs = [`0${colIndex}`,`1${colIndex}`,`2${colIndex}`];
			} else if (Math.abs(diagASum) === 3 || Math.abs(diagBSum) === 3) {
				win = true;
				msg = "Win by DIAGONAL";
				if (Math.abs(diagASum) === 3) {
					winBoxIDs = ["00","11","22"];
				} else {
					winBoxIDs = ["20","11","02"];
				}
			} else {
				this.togglePlayer();
			}

			if (win) {
				this.playing = false;
				this.message = `${msg}: Player ${this.turn}`;
				observer.trigger('game:end', msg, winBoxIDs);
			}

			if (this.squaresRemaining <= 0) {
				this.playing = false;
				this.message = "It was a TIE GAME";
			}

			this.update();
		}

		observer.on('marked', (row, col) => {
			this.squaresRemaining--;
			let mark = (this.turn === "X") ? 1 : -1;
			this.board[row][col] = mark;
			this.checkWin(row, col);
		});

  </script>

  <style>
    /* CSS */
    :scope {}
		.card {
			margin-top: 2em;
		}
  </style>
</app>
