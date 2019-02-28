<app>
	<h1>X</h1>
	<div id="p5-container" onclick={ something }></div>
	<p>MouseX: { x }</p>
	<p>MouseY: { y }</p>

	<label>
		<input type="number" value={ x } placeholder="x-value" step="10" onchange={ changeX }>
	</label>
	<label>
		<input type="number" value={ y } placeholder="y-value" step="10" onchange={ changeY }>
	</label>


  <script>
    // JAVASCRIPT
    let tag = this;

		this.x = 100;
		this.y = 100;

		var init = function(p5) {

		  p5.setup = function() {
		    let canvas = p5.createCanvas(1000, 1000);
				canvas.mousePressed(getXY);
				p5.frameRate(10);
		  };

		  p5.draw = function() {
		    p5.background(0);
		    p5.fill(255);
		    p5.rect(tag.x ,tag.y , 50, 50);
		  };


		};

		var myp5 = new p5(init, 'p5-container');

		changeX(event) {
			this.x = Number(event.target.value);
		}
		changeY(event) {
			this.y = Number(event.target.value);
		}
		something(event) {
			console.log(event);
		}

		function getXY() {
			observer.trigger('mousePressed', p5.mouseX, p5.mouseY);
		}

		observer.on('mousePressed', (mouseX, mouseY) => {
			this.x = mouseX;
			this.y = mouseY;
			this.update();
		});

  </script>

  <style>
    /* CSS */
    :scope {}
  </style>
</app>
