
var app = app || {};

$(document).ready(function() {

  $("#game").height($(window).height());

  $(window).resize(function() {
    $("#game").height($(window).height());
  });

  $('#left_option, #right_option').mouseover(function(){
     $(this).addClass('hover');
  });

  $('#left_option, #right_option').mouseout(function(){
     $(this).removeClass('hover');
  });

  // Kick things off.
  new app.AppView();
});

