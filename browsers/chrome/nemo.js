function getword(info,tab) {

    var word = info.selectionText;
    console.log("Searching for " + word);

    chrome.tabs.create({
        url: "https://www.diki.pl/slownik-angielskiego/?q=" + word,
    })

    var xhr = new XMLHttpRequest();

    var token = "bart-CqB38Dv"
    var translated = "sth"

    var url = "http://localhost:4000/api/stats?token=" + token
      + "&word=" + word
      + "&translated=" + translated

    xhr.open("GET", url, true);
    xhr.onload = function(e) {
      console.log("Response: " + xhr.responseText);
    }
    xhr.send();


}

chrome.contextMenus.create({

	title: "Translate: %s",
	contexts:["selection"],
	onclick: getword,

});
