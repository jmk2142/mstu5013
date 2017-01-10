<form-inputs>
	<strong>forminputs.tag</strong>

	<div class="profile">
		<div class="userForm">
			<h2>FORM</h2>
			<div>
				<label for="username">Username</label>
				<input id="username" type="text" onchange={  }>
			</div>
			<div>
				<label for="image">Image URL</label>
				<input id="image" type="text">
			</div>
			<div>
				<label for="description">Description</label>
				<textarea id="description" rows="8" cols="40" value={ user.description } onkeyup={ updateDescription }></textarea>
			</div>
		</div>

		<div class="preview">
			<h2>PREVIEW</h2>
			<p>{ user.description }</p>
		</div>
	</div>



	<script>

		this.user = {
			username: "Alpha Zulu",
			imageURL: "http://placehold.it/300x300",
			description: "Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat."
		};

		updateDescription(event) {
			console.log(event, this);
			this.user.description = event.target.value;
		}

	</script>




	<style>
		:scope {
			display: block;
			background: #F5F5F5;
			color: #333;
			padding: 15px;
		}
		h2 {
			border-bottom: 1px solid #CCC;
		}
		div {
			padding: 15px;
		}
		.userForm div, .preview div {
			padding: 0 0 10px 0;
		}
		.userForm, .preview {
			flex-grow: 1;
		}
		code {
			background: #DDD;
			border-radius: 4px;
			padding: 0 4px 1px;
			color: #333;
		}
		label {
			display: block;
		}
		.profile {
			display: flex;
			/*width: 100%;*/
		}
		.userForm {
			/*display: flex;*/
		}
	</style>
</form-inputs>
