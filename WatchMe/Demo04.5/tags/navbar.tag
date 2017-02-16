<navbar>
	<strong>navbar.tag</strong>
	<span>Hello { user.first } { user.last }!</span>

	<script>
		console.log('navbar.tag', this);
		this.user = {
			first: "Anonymous",
			last: ""
		};

		this.on('update', function(event){
		  this.user.first = this.opts.userfirst || "Anonymous";
			this.user.last = this.opts.userlast || "";
		});
		
	</script>

	<style>
		:scope {
			display: block;
		}
	</style>
</navbar>
