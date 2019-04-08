<sound-pad onclick={ playSound }>
  <!-- HTML -->


  <script>
    // JAVASCRIPT
		playSound() {
			database.collection('sound-room').doc()
			this.sound.play();
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
    }
  </style>
</sound-pad>
