<zoo>
  <!-- HTML -->
	<h1>Welcome to the Zoo!</h1>

	<animal each={ animals }></animal>

  <script>
    // JAVASCRIPT
    let tag = this;

		this.animals = [{
			name: "Goat",
			legs: 4,
			eatsMeat: false,
			color: "oldlace",
			alive: true,
			imageURL: "http://placehold.it/50x50"
		},{
			name: "Duck",
			legs: 2,
			eatsMeat: true,
			color: "green",
			alive: true,
			imageURL: "http://placehold.it/50x50"
		},{
			name: "Tiger",
			legs: 4,
			eatsMeat: true,
			color: "gold",
			alive: true,
			imageURL: "http://placehold.it/50x50"
		},{
			name: "Dodo",
			legs: 2,
			eatsMeat: false,
			color: "silver",
			alive: true,
			imageURL: "https://images-na.ssl-images-amazon.com/images/I/41YM8y0nc7L.jpg"
		}];

		console.log(this);

  </script>

  <style>
    /* CSS */
    :scope {
      background-color: grey;
    }
  </style>
</zoo>
