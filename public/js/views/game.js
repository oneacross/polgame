
var app = app || {};

$(function($) {

    app.AppView = Backbone.View.extend({

        el: $("#game"),

        new_game: function() {
            $("#more_info").hide();
            $("#message").text("");
            $("#left_option").removeClass('correct Democrat Republican');
            $("#right_option").removeClass('correct Democrat Republican');
            app.game.fetch({success: this.start_game});
        },

        start_game: function(model, resp) {
            // Defaults
            var right_img_url = model.get('right_speaker')['url'] || "http://leslycorazon.wikispaces.com/file/view/head-silhouette-with-question-mark.png";
            var left_party = model.get('left_speaker')['party'];
            var right_party = model.get('right_speaker')['party'];

            // Fill out the game info.
            this.$("#quote").text(model.get('quote')['text']);

            // Distinguish correct from incorrect.
            this.$("#left_option > img").attr("src", model.get('left_speaker')['url']);
            this.$("#right_option > img").attr("src", right_img_url);

            // Set the image's bounding div width
            this.$("#left_option").attr("width", this.$("#left_option > img").attr("width"));
            this.$("#right_option").attr("width", this.$("#right_option > img").attr("width"));

            this.$("#left_option").addClass(left_party);
            this.$("#right_option").addClass(right_party);

            if (model.get('left_speaker')['correct']) {
              this.$("#left_option").addClass('correct');
            }
            else {
              this.$("#right_option").addClass('correct');
            }

            var full_text_url = model.get('quote')['transcript_source_url']
            $("#more_info > a").attr("href", full_text_url);
            $("#next_button").show();
        }
    });
});

