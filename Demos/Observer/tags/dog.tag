<dog>

	<img src="images/dog.png"> <strong>DOG.TAG</strong> <span>{ magicNum }</span>
	<p>The dog hears: { data }</p>
	<button onclick={ talkToCat }>"MEOW" data to Cat</button>

	<script>
		var that = this;
		console.log('dog.tag');

		this.data = "Nothing";
		this.magicNum = 0;

		talkToCat(event) {
			var randomNum = Math.floor(Math.random()*1000);
			var dogMsg = "A howl at the moon would be purrrrfect. ~From Dog";
			observable.trigger('meow', dogMsg, randomNum);
		}

		observable.on('woof', function(passedData, someNum){
		  that.data = passedData;
			that.magicNum = someNum;
			that.update();
		});

		observable.on('reset', function(){
		  that.data = "Nothing";
			that.magicNum = 0;
		});

	</script>

	<style>
		:scope {
			display: block;
			border: 1px solid dodgerblue;
			margin-top: 1em;
			padding: 1em;
		}
		span {
			display: inline-block;
			padding: 0.25em;
			background-color: dodgerblue;
			border-radius: 1em;
			color: #FFF;
			font-weight: bold;
		}
		img {
			width: 50px;
			vertical-align: middle;
		}
	</style>
</dog>
