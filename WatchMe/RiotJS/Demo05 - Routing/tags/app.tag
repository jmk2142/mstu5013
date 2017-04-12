<app>

	<navbar></navbar>

	<page-a if={ page === "page-a" }/>
	<page-b if={ page === "page-b" }/>
	<page-c if={ page === "page-c" }/>

	<script>
		var that = this;
		console.log('app.tag');

		this.page = "page-a"; // Default page

		var appRoute = route.create();
				appRoute('*/..', function(page, subpage){
				  that.page = page;
				});
				appRoute('*', function(page) {
				  that.page = page;
					that.update();
				});

		route.start(true);

	</script>

	<style>
		:scope {
			display: block;
			font-family: Helvetica;
		}
		img {
			width: 100%;
			box-sizing: border-box;
			border: 1px solid #DDD;
			padding: 4px;
			border-radius: 3px;
		}
	</style>
</app>
