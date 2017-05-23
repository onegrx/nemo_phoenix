function getword(info,tab) {

    console.log("Searching for " + info.selectionText);

    chrome.tabs.create({
        url: "https://www.diki.pl/slownik-angielskiego/?q=" + info.selectionText,
    })


}

chrome.contextMenus.create({

	title: "Translate: %s",
	contexts:["selection"],
	onclick: getword,

});
