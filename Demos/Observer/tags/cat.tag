<cat>

	<img src="images/cat.jpg"> <strong>CAT.TAG</strong> <span>{ magicNum }</span>
	<p>The cat hears: { data }</p>
	<button onclick={ talkToDog }>"WOOF" data to Dog</button>

	<script>
		var that = this;
		console.log('cat.tag');

		this.data = "Nothing";
		this.magicNum = 0;

		var alphabet = ['alpha','bravo','charlie','delta','echo','foxtrot','golf','hotel','juliet','kilo','lima','mike','november','oscar','papa','quebec','romeo','sierra','tango','uniform','victor','whiskey','xray','yankee','zulu'];

		talkToDog(event) {
			var randomAlpha = Math.floor(Math.random() * alphabet.length);
			var catMsg = "Go bark up another tree. ~From Cat";
			observable.trigger('woof', catMsg, alphabet[randomAlpha]);
		}

		observable.on('meow', function(passedData, someNum){
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
			border: 1px solid tomato;
			margin-top: 1em;
			padding: 1em;
		}
		span {
			display: inline-block;
			padding: 0.25em;
			background-color: tomato;
			border-radius: 1em;
			font-weight: bold;
		}
		img {
			width: 50px;
			vertical-align: middle;
		}
	</style>
</cat>
