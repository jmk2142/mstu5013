<form-inputs>
	<strong>forminputs.tag</strong>&nbsp;&nbsp;&nbsp;<button type="button" onclick={ showInConsole }>Click to show this tag object in console</button>

	<div class="profile">
		<div class="userForm">
			<h2>FORM</h2>
			<div>
				<label for="username">Username</label>
				<input id="username" type="text" onchange={ updateUsername } value={ user.username }>
			</div>
			<div>
				<label for="image">Image URL</label>
				<input id="image" type="text" onblur={ updateImageURL } placeholder="Enter URL">
			</div>
			<div>
				<label for="description">Description</label>
				<textarea id="description" rows="8" cols="40" value={ user.description } onkeyup={ updateDescription }></textarea>
			</div>
		</div>

		<div class="preview">
			<h2>PREVIEW for { user.username }</h2>
			<div class="preview-profile">
				<div class="thumb">
					<img src={ user.imageURL } alt="user image" />
				</div>
				<p>{ user.description }</p>
			</div>
		</div>
	</div>



	<script>

		// Our source of truth data
		this.user = {
			username: "Alpha Zulu",
			imageURL: "http://placehold.it/300x300",
			description: "Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat."
		};


		// HANDLERS

		/* Notice that I am NOT changing the HTML directly, I am changing the source of truth this.user data. Riot follows a "react" flow for updating the UI. We apply changes to the source of truth data, and Riot "reacts" to that by updating the UI. This keeps Riot short and sweet. */
		updateUsername(event) {
			this.user.username = event.target.value;
		}

		updateImageURL(event) {
			this.user.imageURL = event.target.value;
		}

		updateDescription(event) {
			console.log(event, this);
			this.user.description = event.target.value;
		}

		showInConsole() {
			console.log("\nTag (this) Object:", this, "\n");
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
		.preview-profile {
			display: flex;
		}
		.preview-profile .thumb {
			box-sizing: border-box;
			min-width: 150px;
			border: 1px solid #DDD;
			padding: 4px;
			line-height: 0;
		}
		.preview-profile img {
			width: 100%;
			margin: 0;
			padding: 0;
		}
		.preview-profile p {
			margin-left: 15px;
			margin-top: 0;
		}
	</style>
</form-inputs>
