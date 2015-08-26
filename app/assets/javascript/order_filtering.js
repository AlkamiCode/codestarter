$(document).ready(function() {
  function makeFilter(name) {
    $("#" + name + "-filter").click(function(){
      $("#admin-orders tbody tr").each(function(index, element) {
        var $element = $(element);
        if($element.hasClass(name)) {
          $element.show();
        } else {
          $element.hide();
        }
      })
    });

  }

  makeFilter("ordered");
  makeFilter("paid");
  makeFilter("completed");
  makeFilter("cancelled");
});
