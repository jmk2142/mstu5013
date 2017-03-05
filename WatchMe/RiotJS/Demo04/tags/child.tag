<child>
	<strong>child.tag</strong>
	<button type="button" onclick={ createEvent }>UNMOUNT</button>
	<button type="button" onclick={ showThisInConsole }>THIS Demonstration</button>

	<script>
		// console.log('child.tag', this.parent.x);
		var tag = this;

		this.on('jinsevent', function(event){
		  alert('I heard jinsevent');
		});

		this.createEvent = function(event) {
		  this.trigger('jinsevent');
			this.unmount();
		};

		this.showThisInConsole = function(event){
		  console.log('A:', this);
			this.x = "Holiday";

			setTimeout(function(){
			  console.log('B:', this);
				this.update();
			}.bind(tag), 500);

		};


	</script>

	<style>
	:scope {
		display: block;
		border-radius: 4px;
		padding: 10px;
		font-family: Helvetica;
		background-color: silver;
	}
	</style>
</child>
