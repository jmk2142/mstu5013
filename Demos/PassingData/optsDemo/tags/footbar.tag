<footbar>

	<p>Contact the admin: <a href="mailto:{ opts.user.email }">{ opts.user.username }</a></p>

	<p>Change Username?</p> <input ref="username" type="text" placeholder={ opts.user.username } onchange={ updateUsername }>

	<script>
		var that = this;
		console.log('footbar.tag');

		updateUsername(e) {
			this.opts.user.username = this.refs.username.value;
			this.opts.user.email = this.refs.username.value + "tc.columbia.edu";
			this.parent.update();
		}
	</script>

	<style>
		:scope {
			display: block;
		}
	</style>
</footbar>
