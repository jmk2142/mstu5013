<profile>
	<strong>profile.tag</strong>
	<span>Profile for { user.first } { user.last }</span>

	<script>
		console.log('profile.tag', this);
		this.user = {
			first: "Anonymous",
			last: ""
		};

		this.on('update', function(event){
		  // this.user.first = this.opts.userfirst || "Anonymous";
			// this.user.last = this.opts.userlast || "";
			this.user = this.opts.userdata;
		});
	</script>

	<style>
		:scope {
			display: block;
		}
	</style>
</profile>
