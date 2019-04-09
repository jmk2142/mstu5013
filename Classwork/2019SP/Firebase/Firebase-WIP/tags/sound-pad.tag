<sound-pad onclick={ playSound }>
  <!-- HTML -->


  <script>
    // JAVASCRIPT
		let room = opts.room;
		let roomRef = database.collection('sound-rooms').doc(room.id);

		// let roomRef =
		playSound() {
			roomRef.update({
				soundPlayed: true
			}).then( () => {
				return roomRef.update({
					soundPlayed: false
				});
			});
		}
  </script>

  <style>
    /* CSS */
    :scope {
    	display: inline-block;
    	background-color: blue;
			width: 50px;
			height: 50px;
			margin-right: 1em;
			cursor: pointer;
    }
		:scope:hover {
			background-color: green;
		}
  </style>
</sound-pad>
