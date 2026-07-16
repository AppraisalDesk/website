// ROI Calculator for Credit Unions page
(function() {
  var ordersInput = document.getElementById('orders-per-week');
  var ordersSlider = document.getElementById('orders-slider');
  var amcFeeInput = document.getElementById('amc-fee');
  var advancedToggle = document.getElementById('advanced-toggle');
  var advancedOptions = document.getElementById('advanced-options');

  var resultOrdersYear = document.getElementById('result-orders-year');
  var resultAmcSpend = document.getElementById('result-amc-spend');
  var resultAdCost = document.getElementById('result-ad-cost');
  var resultSavings = document.getElementById('result-savings');
  var resultPerOrder = document.getElementById('result-per-order');

  var AD_COST_PER_ORDER = 55;

  function formatNumber(num) {
    return num.toLocaleString('en-US');
  }

  function formatCurrency(num) {
    return '$' + formatNumber(num);
  }

  function calculate() {
    var ordersPerWeek = parseInt(ordersInput.value) || 50;
    var amcFee = parseInt(amcFeeInput.value) || 150;

    // Clamp values
    ordersPerWeek = Math.max(5, Math.min(500, ordersPerWeek));
    amcFee = Math.max(75, Math.min(300, amcFee));

    var ordersPerYear = ordersPerWeek * 52;
    var amcSpend = ordersPerYear * amcFee;
    var adCost = ordersPerYear * AD_COST_PER_ORDER;
    var savings = amcSpend - adCost;
    var perOrderKept = amcFee - AD_COST_PER_ORDER;

    resultOrdersYear.textContent = formatNumber(ordersPerYear);
    resultAmcSpend.textContent = formatCurrency(amcSpend);
    resultAdCost.textContent = formatCurrency(adCost);
    resultSavings.textContent = formatCurrency(savings);
    resultPerOrder.textContent = formatCurrency(perOrderKept);
  }

  function syncInputs(source) {
    if (source === 'input') {
      ordersSlider.value = ordersInput.value;
    } else {
      ordersInput.value = ordersSlider.value;
    }
    calculate();
  }

  if (ordersInput && ordersSlider) {
    ordersInput.addEventListener('input', function() { syncInputs('input'); });
    ordersSlider.addEventListener('input', function() { syncInputs('slider'); });
  }

  if (amcFeeInput) {
    amcFeeInput.addEventListener('input', calculate);
  }

  if (advancedToggle && advancedOptions) {
    advancedToggle.addEventListener('click', function() {
      advancedOptions.classList.toggle('is-open');
      var isOpen = advancedOptions.classList.contains('is-open');
      advancedToggle.querySelector('svg').style.transform = isOpen ? 'rotate(180deg)' : '';
    });
  }

  // Initial calculation
  calculate();
})();
