<government-vote>
  <!-- HTML -->
	<div class="player-row d-flex justify-content-between" each={ player, i in players }>
		<span>{ player.name }</span>
		<span hide={ player.voted }>
			<button class="btn btn-sm btn-success" onclick={ voteYes }>Ja</button>
			<button class="btn btn-sm btn-danger" onclick={ voteNo }>Nein</button>
		</span>
	</div>

  <script>
    // JAVASCRIPT
    let tag = this;
		this.players = opts.players;
		this.votes = [];

		voteYes(event) {
			let player = event.item.player;
			player.voted = true;
			this.getResults("yes");
		}
		voteNo(event) {
			let player = event.item.player;
			player.voted = true;
			this.getResults("no");
		}
		getResults(vote) {
			this.votes.push(vote);

			if (this.votes.length === this.players.length) {
				let yesVotes = this.votes.filter(vote => vote == "yes").length;
				let noVotes = this.votes.filter(vote => vote == "no").length;
				let electionSuccess = (yesVotes > noVotes) ? true : false;

				this.votes = [];
				this.players.forEach(player => {
					player.voted = false;
				});

				observer.trigger('vote:completed', electionSuccess);
			}
		}
  </script>

  <style>
    /* CSS */
    :scope {}
		.player-row:not(last-of-type) {
			margin-bottom: 1em;
		}
  </style>
</government-vote>
