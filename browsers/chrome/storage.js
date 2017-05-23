var bkg = chrome.extension.getBackgroundPage();

document.addEventListener('DOMContentLoaded', function() {


  if(localStorage["token"]) {
    var x = document.getElementById("token");
    if(x) x.value = localStorage["token"];
  }

  var s = document.getElementById("submit")
  if(s) {
    s.addEventListener("click", handler);
  }
});

function handler() {
  var token = document.getElementById("token").value;
  localStorage["token"] = token;
  bkg.console.log("Saved token " + token);
  alert("Zapisano token: " + token);
}
