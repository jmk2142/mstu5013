// Goto https://news.ycombinator.com/
// Run this script in the console.
var scrapedData = Array.prototype.slice.call(document.querySelectorAll('.athing')).map(function(el){
  return {
		rank: parseInt(el.querySelector('.rank').innerText.replace('.','')),
		title: el.querySelector('.storylink').innerText
  }
});

console.log(scrapedData);
