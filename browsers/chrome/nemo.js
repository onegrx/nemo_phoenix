function getword(info,tab) {

    var xhr = new XMLHttpRequest();

    var token = localStorage["token"];
    if(!token) token = "invalid";

    var word = info.selectionText;
    console.log("Searching for " + word);

    chrome.tabs.create({
        url: "https://www.diki.pl/slownik-angielskiego/?q=" + word,
    })

    var client = new XMLHttpRequest();
    client.open("GET", "http://www.transltr.org/api/translate?text=" + word + "&to=pl&from=en");
    client.setRequestHeader("Accept", "application/json");
    client.onload = function(e) {
      console.log("Response: " + client.responseText);
      var jsonResponse = JSON.parse(client.responseText);
      translated = jsonResponse["translationText"].toLowerCase();
      console.log(translated);

      var url = "http://localhost:4000/api/stats?token=" + token
        + "&word=" + word
        + "&translated=" + translated

      xhr.open("GET", url, true);
      xhr.onload = function(e) {
        console.log("Response: " + xhr.responseText);
      }
      xhr.send();

    }
    client.send();
}

chrome.contextMenus.create({

	title: "Translate: %s",
	contexts:["selection"],
	onclick: getword,

});
