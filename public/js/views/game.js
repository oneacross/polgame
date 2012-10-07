
var app = app || {};

$(function($) {

    app.AppView = Backbone.View.extend({

        el: $("#game"),

        initialize: function() {
            app.game.fetch();

            this.$("#left_option > img").attr("src", "http://upload.wikimedia.org/wikipedia/commons/thumb/e/e9/Official_portrait_of_Barack_Obama.jpg/220px-Official_portrait_of_Barack_Obama.jpg");
            this.$("#right_option > img").attr("src", "http://reason.com/assets/mc/mriggs/MittRomneyProfilePic.jpg");
        }
    });
});

