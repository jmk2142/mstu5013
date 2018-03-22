// https://stackoverflow.com/questions/6038061/regular-expression-to-find-urls-within-a-string
// Takes one String argument.
// If there are no URLs, it will return null.
// If it detects (parses) a URL link, it will return an object separating links from images.
/*
{
	images: [],
	links: []
}
*/

function getLinks(text) {
	var regex = /(http|ftp|https):\/\/([\w_-]+(?:(?:\.[\w_-]+)+))([\w.,@?^=%&:/~+#-]*[\w@?^=%&/~+#-])?/gi;

	var urls = text.match(regex);

	if (!urls) {
		return null;
	}

	var links = {
		images: [],
		sites: []
	};

	for (url of urls) {
		if (url.match(/jpg|gif|png$/)) {
			links.images.push(url);
		} else {
			links.sites.push(url);
		}
	}

	return links;
}

// TESTS
var textA = "My mom is the best. http://moziru.com/images/drawn-heart-3.png please visit https://google.com";
var textB = "My cat is the worst.";
var textC = "https://png.pngtree.com/element_origin_min_pic/16/11/06/fb049143c0cf6c8a8b2a1f8486593cfc.jpg";

console.log("textA: ", getLinks(textA));
console.log("textB: ", getLinks(textB));
console.log("textC: ", getLinks(textC));
