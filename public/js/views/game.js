
var app = app || {};

$(function($) {

    app.AppView = Backbone.View.extend({

        el: $("#game"),

        initialize: function() {
            app.game.fetch({success: this.start_game});
        },

        start_game: function(model, resp) {
            // Defaults
            var right_img_url = model.get('right_speaker')['url'] || "http://leslycorazon.wikispaces.com/file/view/head-silhouette-with-question-mark.png";
            var speaker_width = model.get('left_speaker')['width'];
            var speaker_height = model.get('left_speaker')['height'];

            // Fill out the game info.
            this.$("#quote").text(model.get('quote')['text']);

            // Distinguish correct from incorrect.
            this.$("#left_option > img").attr("src", model.get('left_speaker')['url']);
            this.$("#right_option > img").attr("src", right_img_url);

            if (model.get('left_speaker')['correct']) {
              this.$("#left_option > img").addClass('correct');
            }
            else {
              this.$("#right_option > img").addClass('correct');
            }
        }
    });
});

