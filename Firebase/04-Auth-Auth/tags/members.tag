<members>
	<h2><img src={ userPhotoURL }> Hi { user.displayName } - MEMBERS ONLY</h2>
	<p>This page is showing because user is defined through the auth callback.</p>
	<!-- 16:9 aspect ratio -->
	<div class="embed-responsive embed-responsive-16by9">
		<iframe class="embed-responsive-item" width="560" height="315" src="https://www.youtube.com/embed/LDaayQj-vq8?autoplay=1" src="" frameborder="0" allowfullscreen></iframe>
	</div>

	<h2 class="page-header">MY CONTENT</h2>
	<p>We want to share our content with the world. We want to give the public <strong>read authorization</strong> to anyone that is authenticated.</p>
	<p>It would be very bad if someone could edit our comments though. (Say bad things about Nyan-cat.) We want to deny the public <strong>write authorization</strong>. We only want an authenticated user ... <em>YOU</em> to be able to have <strong>write authorization</strong>.</p>

	<h2 class="page-header">PUBLIC CONTENT</h2>
	<p>Even if it's not yours, we would still like to see it. We want to give <strong>read authorization</strong> to the public.</p>

	<script>
		var that = this;
		this.userPhotoURL = "http://placehold.it/50x50";
		console.log('members.tag');
		console.log(user);
	</script>

	<style>
		:scope {
			display: block;
		}
	</style>
</members>
