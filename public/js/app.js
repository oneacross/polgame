
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

  $("#more_info").hide();

  $('#left_option, #right_option').click(function(){

    // A speaker was selected!

    if ($(this).hasClass("correct")) {
      $("#result").text("You got it!");
      $("#more_info").show();
    }
    else {
      $("#result").text("Nope, try the other guy.");
      $("#more_info").hide();
    }
  });

  // Kick things off.
  new app.AppView();
});

