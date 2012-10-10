
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
      $("#message").text("You got it!");
      $("#more_info").show();
    }
    else {
      $("#message").text("Nope, try the other guy.");
      $("#more_info").hide();
    }
  });

  var view = new app.AppView();

  // Kick things off
  view.new_game();

	$("#next_button").click(function () {
    view.new_game();
	});

});

