$(document).ready(function(){
  $(".page-scroll").click(function() {
    $('html,body').animate({
        scrollTop: $(".text-muted").offset().top},
        1000);
  });
});
