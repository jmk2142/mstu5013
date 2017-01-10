<conditional-example>
	<strong>conditional-example.tag</strong>
	<p>
		In this example we look at some other Riot tag HTML attributes that can help us to create easy UI display sequences.<br> Notice the <code>if=\{ ... \}</code> special Riot attribute we can use to display elements based on a condition.
	</p>

	<div class="login-pane">
		<div if={ loggedIn }>
			LOGGED IN ... <code>this.loggedIn = true;</code>
		</div>
		<div if={ !loggedIn }>
			NOT LOGGED IN ... <code>this.loggedIn = false;</code>
		</div>
		<div class="loginControl">
			<button type="button" onclick={ toggleLogin }>{ loggedIn ? "Log Out" : "Log In"}</button>
		</div>
	</div>


	<div class="cycling-panes">
		<p>
			You can evaluate anything you want inside the <code>if=\{ ... \}</code>. Anything that Javascript will allow.
		</p>
		<div if={ category === "cats" } class="joke">
			<p>Why was the cat sitting on the computer?<br>To keep an eye on the mouse!</p>
		</div>
		<div if={ category === "dogs"} class="joke">
			<p>What an amazing, clever dog we have, darling.<br>He brings in the newspaper every day, and we’ve never even subscribed to any!</p>
		</div>
		<div if={ category === "birds"} class="joke">
			<p>Dog people and cat people don't see eye to eye on a lot of things, but the one thing they can agree on is -</p>
			<p>Bird people are weird.</p>
		</div>
		<select onchange={ setCategory }>
			<option value="cats">Meow Purr</option>
			<option value="dogs">Woof Woof</option>
			<option value="birds">Tweet Twe...</option>
		</select>
	</div>

	<p>
		<code>if=\{ ... \}</code> will add or remove elements from the document. If you only want to <em>show</em> or <em>hide</em>, the <code>show=\{ ... \}</code> and <code>hide=\{ ... \}</code> attributes are also available.
	</p>



	<script>

		this.loggedIn = true;
		this.category = "cats";

		toggleLogin() {
			this.loggedIn = !this.loggedIn;
		}

		setCategory(event) {
			this.category = event.target.value;
		}

	</script>

	<style>
		:scope {
			display: block;
			background: pink;
			padding: 15px;
		}
		.login-pane {
			background: pink;
		}
		.login-pane > div:not(.loginControl) {
			background-color: #F5F5F5;
			padding: 15px;
			margin-bottom: 15px;
		}
		.joke {
			background-color: #F5F5F5;
			padding: 15px;
			margin-bottom: 15px;
		}
	</style>

</conditional-example>
