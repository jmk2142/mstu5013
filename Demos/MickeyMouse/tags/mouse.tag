<mouse>

	<img src="images/{ imgFilename }.gif">
	<p>My mouse's name is: <strong>{ mouseName }</strong>.</p>
	<button onclick={ toggleMouse }>Change Mouse</button>

	<script>
		var that = this;

		this.mouseName = "Mickey";
		this.imgFilename = "mickey";

		// Shorthand ES6 Function declaration
		toggleMouse(event) {
			if (this.mouseName == "Mickey") {
				this.mouseName = "Minnie";
			} else {
				this.mouseName = "Mickey";
			}

			this.imgFilename = this.mouseName.toLowerCase();
		}

		// Same function as above but spelled out in more traditional form.
		// this.toggleMouse = function(event){
		// 	if (this.mouseName == "Mickey") {
		// 		this.mouseName = "Minnie";
		// 	} else {
		// 		this.mouseName = "Mickey";
		// 	}
		// };

	</script>

	<style>
		:scope {
			display: block;
		}
		img {
			width: 100px;
		}
	</style>
</mouse>
