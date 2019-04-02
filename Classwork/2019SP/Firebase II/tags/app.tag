<app>
	<h1>TODO</h1>

	<button type="button" onclick={ toggleMode }>Toggle Mode</button>

	<todo-basic if={ mode === "basic" } title={ opts.title } items={ opts.items } />
	<todo-realtime if={ mode === "realtime" } title={ opts.title } items={ opts.items } />

	<script>
		this.mode = "basic";

		toggleMode(event) {
			if (this.mode === "basic") {
				this.mode = "realtime";
			} else {
				this.mode = "basic";
			}
		}
	</script>

</app>
