<animal>
  <!-- HTML -->
	<!-- <div class="border" style="border-color:{ color };background-color:{ alive ? '#FFF':'red' };"> -->
	<div class="border { dead:!alive }" style="border-color:{ color };">
		<img src={ imageURL } alt="animal { name }">
		<p>{ name } has { legs } legs.</p>

		<input type="text" ref="inputName" placeholder="Enter name" onkeypress={ changeName }>

		<br>

		<button type="button" onclick={ cook }>Cook { name }</button>
	</div>

  <script>
    // JAVASCRIPT
    let tag = this;
		console.log(this);

		this.cook = function() {
      this.alive = false;
			console.log(this);
		};

		this.changeName = function(event) {
			if (event.code === "Enter") {
				var newName = this.refs.inputName.value;
				this.name = newName;
				this.refs.inputName.value = "";
			}
    };


  </script>

  <style>
    /* CSS */
    :scope {}

    .border {
      border: 1em solid red;
      padding: 10px 10px 10px 10px;
      margin-bottom: 1em;
    }
		.dead {
			background-color: black;
			color: white;
			text-decoration: line-through;
		}
		img {
			width: 100%;
		}
  </style>
</animal>
