// ROI Calculator for Credit Unions page
(function() {
  var range = document.getElementById('ordersRange');
  var ordersOut = document.getElementById('ordersOut');
  var ordersYearDisplay = document.getElementById('ordersYearDisplay');
  var amcYear = document.getElementById('amcYear');
  var adYear = document.getElementById('adYear');
  var annualKeep = document.getElementById('annualKeep');

  // Exit if calculator elements aren't on page
  if (!range || !ordersOut) return;

  var AMC = 150;
  var AD = 55;
  var KEPT = 95;
  var WEEKS = 52;

  function fmtNum(n) {
    return Math.round(n).toLocaleString('en-US');
  }

  function fmtCurrency(n) {
    return '$' + fmtNum(n);
  }

  function paintTrack() {
    var pct = (range.value - range.min) / (range.max - range.min) * 100;
    range.style.backgroundSize = pct + '% 100%';
  }

  function recalc() {
    var ordersPerWeek = parseInt(range.value, 10);
    var ordersPerYear = ordersPerWeek * WEEKS;
    var amcCost = ordersPerYear * AMC;
    var adCost = ordersPerYear * AD;
    var savings = ordersPerYear * KEPT;

    ordersOut.textContent = ordersPerWeek;
    if (ordersYearDisplay) {
      ordersYearDisplay.textContent = fmtNum(ordersPerYear) + ' a year';
    }
    amcYear.textContent = fmtCurrency(amcCost);
    adYear.textContent = fmtCurrency(adCost);
    annualKeep.textContent = fmtCurrency(savings);
    paintTrack();
  }

  range.addEventListener('input', recalc);
  recalc();
})();
