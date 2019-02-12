<players-panel>
	<h3>PLAYERS</h3>

  <div class={} each={ player, i in opts.players }>{ player.name }</li>

  <script>
    // JAVASCRIPT
    let tag = this;

  </script>

  <style>
    /* CSS */
		:scope {
    	display: block;
			border: 1px solid #DDD;
			border-radius: 0.5em;
			padding: 1em;
			margin: 1em 0;
    }
    .special {
      background-color: #333333;
      color: #FFFFFF;
    }
  </style>
</players-panel>
