document.addEventListener("turbolinks:load", function() {
  $(document).trigger('refresh_autonumeric');
  $(document).on('change', refresh_grand_total);
});

function refresh_grand_total() {
  var interval = document.getElementById("plan_interval").value;
  var amount = document.getElementById("plan_virtual_dollars_val").value;
  var total_plan_price = document.getElementById("grand-total");
  var total = "$" + interval * amount;
  total_plan_price.innerHTML = total;
}
window.onload = refresh_grand_total;
