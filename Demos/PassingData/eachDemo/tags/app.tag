<app>

	<!-- <telegram each={ telegrams }></telegram> -->

	<!-- <hr><br><br><br> -->

	<telegram each={ telegram in telegrams }></telegram>


	<div class="xDiv" each={ x in images }>
		<p>IMAGE</p>
		<img src={ x } alt="image of a box">
	</div>


	<script>
		var that = this;
		console.log('app.tag');

		this.telegrams = [
			{
				to: "abc123",
				from: "def456",
				msg: "Hello"
			},{
				to: "zzz999",
				from: "def456",
				msg: "Hola"
			},{
				to: "aaa000",
				from: "def456",
				msg: "Konnichiwa"
			}
		];

		this.images = [
			"http://via.placeholder.com/100x100/FFEEDD/FFFFFF",
			"http://via.placeholder.com/100x100/3366EE/FFFFFF",
			"http://via.placeholder.com/100x100/DD22AA/FFFFFF"
		];
	</script>

	<style>
		:scope {
			display: block;
		}
	</style>
</app>
