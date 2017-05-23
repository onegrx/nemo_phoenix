var bkg = chrome.extension.getBackgroundPage();

document.addEventListener('DOMContentLoaded', function() {

  var s = document.getElementById("submit")
  if(s) {
    s.addEventListener("click", handler);
  }
});

function handler() {
  var token = document.getElementById("token").value;
  localStorage["token"] = token;
  bkg.console.log("Saved token " + token);
}
