<app>
  <!-- HTML -->
  <div class={ foo } onclick={ bar } style="color:{ myColor };">
		<p>{ myMsg }</p>

		<p>{ who } went to { place } and bought { getRandom() } sushi.</p>
	</div>
	<button show={ buttonON } type="button" onclick={ altFunc }>ALT BUTTON</button>

  <script>
    // JAVASCRIPT
    let tag = this;

    this.myMsg = "Hello!";
    this.foo = "special";
		this.myColor = "#FFFFFF";

		this.who = "Daniel";
		this.place = "Japan";

		this.buttonON = true;

		this.getRandom = function(){
		  return Math.floor(Math.random() * 100);
		};

    this.bar = function(event) {
      alert('CLICKED!');
      tag.myMsg = "Goodbye!";
			tag.myColor = `rgb(
				${Math.floor(Math.random() * 255)},
				${Math.floor(Math.random() * 255)},
				${Math.floor(Math.random() * 255)})`;
    };
		// this.update();

		this.altFunc = function() {
			console.log(tag)
			this.myMsg = "Abracadabra";
			this.buttonON = false;
		}
  </script>

  <style>
    /* CSS */
    :scope {}
    .special {
      background-color: #333333;
      color: #FFFFFF;
			margin-bottom: 1em;
    }
  </style>
</app>
