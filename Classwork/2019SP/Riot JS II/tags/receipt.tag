<receipt>
  <!-- HTML -->
	<div class="row">
		<div class="col">
			<div class="card">
				<div class="card-header">
					RECEIPT
				</div>
				<div class="card-body">
					<p>Hi { name }.</p>
					<p>Your order will be served at: { time }</p>
					<hr>
					<p>You ordered:</p>
					<table class="table">
						<tr>
							<th>ITEM</th>
							<th>PRICE</th>
						</tr>
						<tr each={ item, i in foodItems }>
							<td>{ item }</td>
							<td>{ toDollars(priceLookup[item]) } { servings > 1 ? "x " + servings : "" }</td>
						</tr>
						<tr class="bill">
							<td>SUBTOTAL</td>
							<td>{ toDollars(subTotal) }</td>
						</tr>
						<tr class="table-danger">
							<td>TAX</td>
							<td>{ toDollars(tax) }</td>
						</tr>
						<tr class="table-success">
							<td><strong>TOTAL</strong></td>
							<td><strong>{ toDollars(total) }</strong></td>
						</tr>
					</table>
				</div>
				<div class="card-footer">
					Data transformations.
				</div>
			</div>
		</div>
		<div class="col">
			<div class="card">
				<div class="card-header">
					<span class="badge badge-primary">receipt.tag</span>
				</div>
				<div class="card-body">
					<pre>receipt.tag: <code ref="json"></code></pre>
				</div>
				<div class="card-footer">

				</div>
			</div>
		</div>
	</div>



  <script>
    // JAVASCRIPT
    let tag = this;

		const NYCTAX = 0.085;

		this.priceLookup = {
			pancakes: 7.00,
			waffles: 10.50,
			country: 15.50,
			sausage: 5.00,
			bacon: 4.50,
			english: 3.25,
			coffee: 3.25,
			tea: 2.50
		};

		this.name = opts.breakfast.fullName;
		this.servings = opts.breakfast.servings;
		this.time = opts.breakfast.time;

		this.foodItems = [
			opts.breakfast.mainDish,
			...opts.breakfast.sides,
			opts.breakfast.drink
		];

		this.subTotal = this.foodItems
			.map( food => this.priceLookup[food] )
			.reduce( (accumulator, currentValue) => accumulator + currentValue)
			* this.servings;

		this.tax = this.subTotal * NYCTAX;
		this.total = this.subTotal + this.tax;

		toDollars(amount) {
			return amount.toLocaleString("en-US", {style:"currency", currency:"USD"});
		}

		this.on('mount', () => {
			this.refs.json.textContent = JSON.stringify(this, null, 2);
		});

  </script>

  <style>
    /* CSS */
    :scope {}
		.bill {
			border-top: 2px solid #333;
		}
  </style>
</receipt>
