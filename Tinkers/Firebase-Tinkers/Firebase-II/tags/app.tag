<app>
  <!-- HTML -->
	<section>
		<h1 if={ !username }>Kitchen Lab</h1>
		<div if={ username }>
			<h1>Welcome to Kitchen Lab { username }! <button onclick={ logout }>LOGOUT</button></h1>
			<p>
				Restrictions:
				<span class="badge" each={ restriction in restrictions }>{ restriction }</span>
			</p>

		</div>

		<div show={ loginMode && !username }>
			<h2>Login</h2>
			<input ref="loginUsername" value="" placeholder="Username" onkeypress={ loginEnter }>
			<button type="button" onclick={ login }>LOGIN</button>
			<button type="button" onclick={ toggleMode }>Don't have a login?</button>
			<label>
				<input ref="remember" type="checkbox"> Remember Me
			</label>
			<p show={ loginErrorMsg }>{ loginErrorMsg }</p>

		</div>

		<div show={ !loginMode && !username }>
			<h2>Register</h2>
			<div>
				<p>Basic Chef Info:</p>
			</div>
			<input ref="username" value="" placeholder="Choose a username">
			<input ref="fullName" value="" placeholder="First Last">
			<select ref="level">
				<option value="beginner" selected>Beginner</option>
				<option value="intermediate">Intermediate</option>
				<option value="expert">Advanced</option>
			</select>
			<div>
				<p>Restrictions:</p>
				<label>
					<input type="checkbox" value="vegetarian"> <span>Vegetarian</span>
				</label>
				<label>
					<input type="checkbox" value="gluten"> <span>Gluten Free</span>
				</label>
				<label>
					<input type="checkbox" value="lactose"> <span>Lactose Intolerant</span>
				</label>
			</div>
			<br>
			<button type="button" onclick={ register }>Register</button>
			<button type="button" onclick={ toggleMode }>BACK</button>
		</div>
	</section>

	<section if={ username }>
		<h2>Kitchen Laboratories</h2>
		<kitchen-lab-editor user={ user }></kitchen-lab-editor>
		<kitchen-lab-room></kitchen-lab-room>
		<kitchen-lab-browse user={ user }></kitchen-lab-browse>
	</section>

  <script>
    // JAVASCRIPT
    let tag = this;

		this.loginMode = true;
		this.username;

		toggleMode() {
			this.loginMode = !this.loginMode;
		}

		loginEnter(event) {
			if (event.code === "Enter") {
				this.login()
			}
		}
		login() {
			this.loginErrorMsg = "";
			let username = this.refs.loginUsername.value;
			database.collection('kitchen-users').doc(username).get().then(doc => {

				if (doc.data()) {
					this.user = doc.data();
					this.username = this.user.username;
					this.fullName = this.user.fullName;
					this.restrictions = this.user.restrictions;

					let remember = this.refs.remember.checked;
					if (remember) {
						localStorage.setItem('kitchen-user', JSON.stringify(this.user));
					}

					this.reset();
				} else {
					this.loginErrorMsg = "Sorry, we couldn't find your username.";
				}

				this.update();
			});
		}

		enterKey(event) {
			if (event.code === "Enter") {
				this.register();
			}
		}
		register() {
			this.username = this.refs.username.value.replace(/\s/g, '').trim().toLowerCase();

			let checkedBoxes = this.root.querySelectorAll("[type='checkbox']:checked");

			this.user = {
				username: this.username,
				fullName: this.refs.fullName.value,
				level: this.refs.level.value,
				restrictions: [...checkedBoxes].map(el => el.value)
			};

			database.collection('kitchen-users').doc(this.username).set(this.user).then(doc => {
				this.username = this.user.username;
				this.fullName = this.user.fullName;
				this.restrictions = this.user.restrictions;
				this.reset();
				this.update();
			});
		}

		logout() {
			this.user = null;
			this.username = null;
			this.fullName = null;
			this.level = null;
			this.restrictions = null;
			localStorage.removeItem('kitchen-user');
		}
		reset() {
			this.refs.loginUsername.value = "";
			this.refs.username.value = "";
			this.refs.fullName.value = "";
			this.refs.level.value = "beginner";
			let checkedBoxes = this.root.querySelectorAll("[type='checkbox']:checked");
			[...checkedBoxes].forEach(el => {
				el.checked = false;
			});
			this.loginMode = true;
			this.loginErrorMsg = "";
		}

		this.on('before-mount', () => {
			let localUser = JSON.parse(localStorage.getItem('kitchen-user'));

			if (localUser) {
				this.user = localUser;
				this.username = localUser.username;
				this.fullName = localUser.fullName;
				this.level = localUser.level;
				this.restrictions = localUser.restrictions;
			}
		});

  </script>

  <style>
    /* CSS */
    :scope {}
    section {
    	border-bottom: 2px dashed grey;
      margin-bottom: 2em;
			padding-bottom: 2em;
    }
  </style>
</app>
