<app>
	<div class="preview">
		<h1>PREVIEW</h1>
		<div class="card { dark:modeDark }">
			<img src={ imageURL } alt="">
			<div class="title">{ title.toUpperCase() }</div>
			<p>{ body }</p>
		</div>
	</div>

	<div class="editor">
		<h1>EDITOR</h1>
		<label>
			<div>TITLE</div>
			<input type="text" value="" placeholder="Title" ref="title">
		</label>
		<label>
			<div>IMAGE</div>
			<input type="text" value="" placeholder="Image URL" ref="image">
		</label>
		<label>
			<div>BODY</div>
			<textarea rows="4" placeholder="Your Story" ref="body"></textarea>
		</label>
		<div class="label-radio" onclick={ toggleMode }>
			<div>MODE</div>
			<label>
				Light <input type="radio" name="mode" value="light" ref="modeLight" checked>
			</label>
			<label>
				Dark <input type="radio" name="mode" value="dark" ref="modeDark">
			</label>
		</div>
		<div class="actions">
			<button type="button" onclick={ reset }>RESET</button>
			<button type="button" onclick={ updateCard }>UPDATE</button>
		</div>
	</div>

	<script>
		console.log('app.tag');

		this.title = "TITLE HERE";
		this.body = "Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur.";
		this.imageURL = "http://placehold.it/200x200";
		this.modeDark = false;

		this.toggleMode = function(event){
			if (event.target.type === "radio") {
				if (event.target.value === "dark") {
					this.modeDark = true;
				} else {
					this.modeDark = false;
				}
			}
		};

		this.updateCard = function(event){
		  this.title = this.refs.title.value;
			this.imageURL = this.refs.image.value;
			this.body = this.refs.body.value;
		};

		this.reset = function(event){
		  this.refs.title.value = "";
			this.refs.image.value = "";
			this.refs.body.value = "";
			this.refs.modeLight.checked = true;
			this.refs.modeDark.checked = false;

			this.title = "TITLE HERE";
			this.body = "Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur.";
			this.imageURL = "http://placehold.it/200x200";
			this.modeDark = false;

			this.refs.title.focus();
		};

	</script>

	<style>
		:scope {
			display: block;
			font-family: Helvetica;
		}
		.card {
			border: 1px solid #CCC;
			display: inline-block;
			text-align: center;
			width: 200px;
			/*height: 300px;*/
			box-sizing: border-box;
			padding: 10px;
			border-radius: 4px;
		}
		.card img {
			width: 100%;
			margin-bottom: 10px;
		}
		.card p {
			font-size: 10px;
			text-align: left;
		}
		.dark {
			background-color: #333;
			color: #FFF;
		}
		.editor {
			margin-top: 10px;
			padding: 10px;
			border: 1px solid #CCC;
			border-radius: 4px;
			display: inline-block;
		}
		.editor > label, div.label-radio {
			display: block;
			margin-bottom: 10px;
			font-size: 12px;
		}
		label > div:first-child, .label-radio > div:first-child {
			width: 75px;
			display: inline-block;
			vertical-align: top;
		}
		.editor button {
			padding: 10px;
			border-radius: 4px;
			background-color: #2196f3;
			border-color: #3f51b5;
			color: #FFF;
			cursor: pointer;
		}
		.editor button:active {
			background-color: #e91e63;
		}
		.actions {
			text-align: right;
		}
		.label-radio > div:first-child {
			margin-top: 4px;
		}
	</style>
</app>
