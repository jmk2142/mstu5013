<app>
	<h1>Great APP</h1>

	<div class="gallery">
		<h4>{ galleryTitle }</h4>
		<photo-card></photo-card>
		<photo-card></photo-card>
		<photo-card></photo-card>
	</div>

	<script>
		console.log("TEST");
		this.galleryTitle = "Vacation Photos";
	</script>

	<style>
		:scope {
			color: blue;
			font-family: Helvetica;
		}
		.gallery {
			border: 1px solid silver;
			background-color: #F5F5F5;
			padding: 10px;
		}
	</style>
</app>
