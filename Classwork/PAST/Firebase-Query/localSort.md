# Array.sort() for those of you who are more curious

var list = [2,1,3,6,5,9,4,7,0,8];
list.sort(function(a, b){
	return a < b; // [0,1,2,3,4,5,6,7,8,9]
});

If compareFunction(a, b) is less than 0, sort a to an index lower than b, i.e. a comes first.

If compareFunction(a, b) returns 0, leave a and b unchanged with respect to each other, but sorted with respect to all different elements. Note: the ECMAscript standard does not guarantee this behaviour, and thus not all browsers (e.g. Mozilla versions dating back to at least 2003) respect this.

If compareFunction(a, b) is greater than 0, sort b to an index lower than a, i.e. b comes first.

compareFunction(a, b) must always return the same value when given a specific pair of elements a and b as its two arguments. If inconsistent results are returned then the sort order is undefined.
