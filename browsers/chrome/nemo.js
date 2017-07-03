var API_KEY = "trnsl.1.1.20170703T043733Z.f447f002f919a8c9.311eddfe75333dc54d75bdf8488e0da2de29d0e3"

function getword(info,tab) {

    var xhr = new XMLHttpRequest();

    var token = localStorage["token"];
    if(!token) token = "invalid";

    var word = info.selectionText;
    console.log("Searching for " + word);

    chrome.tabs.create({
        url: "https://www.diki.pl/slownik-angielskiego/?q=" + word,
    })

    "https://translate.yandex.net/api/v1.5/tr.json/translate?key=" + API_KEY + "&text=" + word + "&lang=en-pl"

    var client = new XMLHttpRequest();
    client.open("GET", "https://translate.yandex.net/api/v1.5/tr.json/translate?key=" + API_KEY + "&text=" + word + "&lang=en-pl");
    client.onload = function(e) {
      console.log("Response: " + client.responseText);
      var jsonResponse = JSON.parse(client.responseText);
      translated = jsonResponse["text"][0].toLowerCase();
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
