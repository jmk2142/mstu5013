<reveal>
  <!-- HTML -->
	<!-- <div show={ numPlayers < 7 }>
		<h1>Game of 5-6 Players</h1>
		<ul>
			<li>Everybody close your eyes.</li>
			<li>Fascist and Hitler, open your eyes and
			acknowledge each other.</li>
			<li>[Take a long pause]</li>
			<li>Everyone close your eyes.</li>
			<li>Everyone can open your eyes. If anyone is
			confused or something went wrong, please tell
			the group now.</li>
		</ul>
	</div>

	<div show={ numPlayers > 6 }>
		<h1>Game of 7-10 Players</h1>
		<ul>
			<li>Everybody close your eyes and extend your hand into a fist in front of you.</li>
			<li>All Fascists who are NOT Hitler should open their eyes and acknowledge each other.</li>
			<li>Hitler - keep your eyes closed but put your thumb out into a thumbs-up gesture.</li>
			<li>Fascists, take note of who has an extended thumb - that player is Hitler.</li>
			<li>[Take a long pause]</li>
			<li>Everyone close your eyes and put your hands down.</li>
			<li>Everyone can open your eyes. If anyone is confused or something went wrong, please tell the group now.</li>
		</ul>
	</div> -->

	<h1>SECRET IDENTITIES!!!</h1>
	<ol>
		<li>REVEAL YOUR IDENTITY CARD.</li>
		<li><strong>Do not let anyone else see your secret identity.</strong></li>
		<li>Cards will be "sealed" after they are opened.</li>
		<li>If your card is already sealed, someone opened it. You must restart the game.</li>
		<li>Do not forget your identity or the secret INTEL.</li>
		<li>If you are confused, all player identities should be reset (do over.)</li>
	</ol>

	<div class="d-flex justify-content-center flex-wrap">
		<player-card-secret each={ players } in-review={ inReview }></player-card-secret>
	</div>

  <script>
    // JAVASCRIPT
    let tag = this;

		this.players = this.opts.players;
		this.numPlayers = this.opts.players.length;

		this.inReview = false;

		toggleInReview(beingReviewed) {
			this.inReview = beingReviewed;

			if (!this.inReview && this.players
					.map(player => player.ready)
					.every(ready => ready)
			) {
				this.parent.playGame();
			} else {
				this.update();
			}

		}

  </script>

  <style>
    /* CSS */
    :scope {}
  </style>
</reveal>
