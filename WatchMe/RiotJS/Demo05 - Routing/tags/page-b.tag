<page-b>

	<subnav></subnav>

	<h1>PAGE B - BAKING</h1>

	<subpage-breads if={ subpage === "breads" }></subpage-breads>
	<subpage-cakes if={ subpage === "cakes" }></subpage-cakes>
	<subpage-cookies if={ subpage === "cookies" }></subpage-cookies>
	<p if={ !subpage }><strong>NO SUBPAGE</strong></p>

	<script>
		var that = this;
		console.log('page-b.tag');

		this.subpage = "cakes";

		var subRoute = route.create();
				subRoute('page-b/*', function(subpage) {
					console.log(subpage);
					that.subpage = subpage;
					that.update();
				});
				subRoute('page-b', function(subpage){
				  that.subpage = "cakes";
					that.update();
				});

		this.on('mount', function(){
		  route.exec();
		});

		// Since this page-b is unmounted often, you need to STOP this subRoute
		// when you unmount page-b. Otherwise, the subroute still exists, listens,
		// and the next time you open up page-b - things get weird.
		this.on('unmount', function() {
		  subRoute.stop();
		});
	</script>

	<style>
		:scope {
			display: block;
		}
	</style>
</page-b>
