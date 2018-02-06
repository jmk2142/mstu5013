<gallery-jin>

	<strong>gallery-jin.tag</strong>
	<div class="images">
		<photo-jin each={ word in words }></photo-jin>
	</div>

	<script>
		this.words = ["Alpha","Bravo","Charlie","Delta","Echo"];
	</script>

	<style>
		:scope {
			display: block;
			padding: 15px;
			background: pink;
		}
		.images {
			margin-top: 15px;
			text-align: center;
		}
		photo-jin {
			margin-right: 30px;
			margin-bottom: 30px;
			background: #333;
			color: #FFF;
			border-width: 0;
		}
	</style>
</gallery-jin>
