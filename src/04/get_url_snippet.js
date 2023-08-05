// light version
let results = new Array();
var urls = document.getElementsByTagName('a');
for (urlIndex in urls) {
    url = urls[urlIndex]
    if(url.href && url.href.indexOf('://') !== -1) {
        results.push(url.href)
    }
};
console.log(results)