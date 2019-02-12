<card-component class="card">
  <!-- HTML -->
  <div class="card-header">
  	Title: <strong>{ title }</strong>
  </div>
	<div class="card-body">
		Content: <em>{ opts.cardContent }</em>
	</div>
	<div class="card-footer">
		Footer:
	</div>

  <script>
    // JAVASCRIPT
    let tag = this;

		this.title = opts.title;

  </script>

  <style>
    /* CSS */
    :scope {}
  </style>
</card-component>
