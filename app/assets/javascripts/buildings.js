document.addEventListener("DOMContentLoaded", function(event) {
  var toggleLinks = document.querySelectorAll(".toggle-link");

  toggleLinks.forEach(function(link) {
    link.addEventListener("click", function(event) {
      event.preventDefault();
      var historicalRentsDiv = link.parentElement.parentElement.querySelector(".historical-rents");
      var wasShowing = historicalRentsDiv.style.display == "block";

      if (wasShowing) {
        historicalRentsDiv.style.display = "none";
        link.innerText = "Show historical rents";
      } else {
        historicalRentsDiv.style.display = "block";
        link.innerText = "Hide historical rents";
      }

    });
  });
});
