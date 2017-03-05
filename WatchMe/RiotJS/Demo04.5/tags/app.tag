<app>
	<strong>app.tag</strong>
	<em>{ user.first }'s page</em>

	<navbar userfirst={ user.first } userlast={ user.last }></navbar>
	<profile userdata={ user }></profile>

	<script>
		console.log('app.tag');
		this.user = {
			first: "Anonymous",
			last: ""
		};

		this.getUserFromDB = function(event) {
		  setTimeout(function(){

				this.user = {
					first: "Jin",
					last: "Kuwata"
				};
				console.log('data received');
				this.update();

		  }.bind(this), 1500);

			console.log('getUserFromDB was called()');
		};

		this.getUserFromDB();

	</script>

	<style>
		:scope {
			display: block;
		}
	</style>
</app>
