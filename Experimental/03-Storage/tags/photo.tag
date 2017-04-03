<photo>
	<div class="thumbnail">
		<a href={ photoURL }>
			<img src={ photoURL }>
		</a>
		<div class="caption">
			<h3>{ title || "Untitled" }</h3>
			<p>{ caption || "No Caption" }</p>
			<small>By { author }</small>
		</div>
	</div>

	<script>
		var that = this;
		console.log('photo.tag');
	</script>

	<style>
		:scope {
			display: block;
		}
	</style>
</photo>
