
var app = app || {};

$(function($) {

    app.AppView = Backbone.View.extend({

        el: $("#game"),

        initialize: function() {
            app.game.fetch({success: this.start_game});
        },

        start_game: function(model, resp) {
            // Defaults
            var wrong_speaker_img_url = model.get('wrong_speaker')['url'] || "http://leslycorazon.wikispaces.com/file/view/head-silhouette-with-question-mark.png";
            var speaker_width = model.get('speaker')['width'];
            var speaker_height = model.get('speaker')['height'];

            // Fill out the game info.
            this.$("#quote").text(model.get('quote')['text']);

            this.$("#left_option > img").attr("src", model.get('speaker')['url']);
            this.$("#right_option > img").attr("src", wrong_speaker_img_url);
        }
    });
});

