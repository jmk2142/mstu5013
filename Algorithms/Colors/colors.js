function makeColors(numColors=6) {
	let colors = [];

	let rStart = 0;
	let gStart = Math.floor(Math.random() * 256);
	let bStart = gStart;

	let gradRange = 256 / (numColors - 1);

	for (let i=0; i < numColors; i++) {
		colors.push({
			r: rStart + (gradRange * i), g: gStart, b: bStart
		});
	}

	return colors;
}


function makeRGBStr(colorList) {
	return colorList.map(color => `rgb(${color.r},${color.g},${color.b})`);
}

let rgbs = makeRGBStr(makeColors(100));

// Requires LoDash (see index.html)
_.shuffle(rgbs).forEach(rgb => {
	document.body.innerHTML += `<div class="box" style="background-color:${rgb};">x</div>`;
});
