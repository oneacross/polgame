
$(document).ready(function() {

  $("#game").height($(window).height());

  $(window).resize(function() {
    $("#game").height($(window).height());
  });
});

