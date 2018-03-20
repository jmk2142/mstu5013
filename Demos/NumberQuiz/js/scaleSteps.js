function makeSet(min, max, minSize, maxSize) {
	var numList = [];

	for (var n=min; n<=max; n++) {
		numList.push({ num: n });
	}

	var sizeStep = (maxSize - minSize) / (numList.length - 1);
	var increment = 0;

	for (item of numList) {
		item.size = minSize + increment;
		increment += sizeStep;
	}

	return numList;
}

function getSize(num, set) {
	var numItem = set.find(function(setItem) {
		return setItem.num === num;
	});
	return numItem ? numItem.size : undefined;
}
