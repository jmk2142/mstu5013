<mail-app>

	<button type="button" name="button" onclick={ toggleEditor }>COMPOSE</button>

	<div class="mail-list">
		<mail-item each={ emailList }></mail-item>
	</div>

	<mail-editor if={ creatingEmail }></mail-editor>

	<script>
		// console.log(this);
		var that = this;

		this.creatingEmail = false;

		this.toggleEditor = function(event) {
		  this.creatingEmail = true;
		};

		this.closeEditor = function(event) {
		  that.creatingEmail = false;
			that.update();
		};


		this.aardvark = "I'm a party animal.";



		this.emailList = [{
			toEmail: "alpha@alpha.com",
			subject: "some subject",
			body: "I like turtles."
		},{
			toEmail: "alpha@alpha.com",
			subject: "some subject",
			body: "I like turtles."
		},{
			toEmail: "alpha@alpha.com",
			subject: "some subject",
			body: "I like turtles."
		}];

	</script>

	<style>
		:scope {
			display: block;
			border: 1px solid orange;
			padding: 10px;
			position: fixed;
			height: 100%;
			width: 100%;
		}
		.mail-list {
			margin-top: 15px;
		}
	</style>


</mail-app>
