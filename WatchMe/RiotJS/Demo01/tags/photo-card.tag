<photo-card>
	<img src={ imageURL }/>
	<p if={ imageCaption }>{ imageCaption }</p>
	<img class="noImageIcon" src="http://www.emoji.co.uk/files/google-emojis/smileys-people-android/7285-thumbs-down-sign.png" if={ !imageCaption }/>

	<script>
		this.imageURL = "http://placehold.it/100x100";
		this.imageCaption = "Caption Here";
	</script>

	<style>
		:scope {
			display: inline-block;
			border: 1px solid #CCC;
			border-radius: 6px;
			margin: 0;
			padding: 10px;
			width: 100px;
		}
		.noImageIcon {
			width: 100%;
		}
	</style>
</photo-card>
