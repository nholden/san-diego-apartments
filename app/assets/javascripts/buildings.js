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

  var bedsFilters = document.querySelectorAll(".beds-filter");

  bedsFilters.forEach(function(bedsFilter) {
    var filters = bedsFilter.querySelectorAll(".filter");

    filters.forEach(function(filter) {
      var buildingId = filter.id.match(/^\d/)[0];
      var beds = filter.id.match(/(\d)br/)[1];
      var buildingDiv = document.querySelector("#building_" + buildingId);
      var units = buildingDiv.querySelectorAll(".unit");
      var unitsWithBeds = [];

      units.forEach(function(unit) {
        if (unit.dataset.beds == beds) {
          unitsWithBeds.push(unit);
        }
      });

      if (unitsWithBeds.length > 0) {
        filter.style.display = "block";
        var rents = [];

        unitsWithBeds.forEach(function(unit) {
          rents.push(unit.dataset.rent);
        });

        var startingRent = rents.sort()[0];
        var startingRentSpan = filter.querySelector("span");
        startingRentSpan.innerText = "from " + startingRent;

        var checkbox = filter.querySelector("input");

        checkbox.addEventListener("change", function(event) {
          if (checkbox.checked == true) {
            showDivs(unitsWithBeds);
          } else {
            hideDivs(unitsWithBeds);
          }
        });
      }
    });
  });

  function showDivs(divs) {
    divs.forEach(function(div) {
      div.style.display = "block";
    });
  }

  function hideDivs(divs) {
    divs.forEach(function(div) {
      div.style.display = "none";
    });
  }
});
