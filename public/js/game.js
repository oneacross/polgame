
var app = app || {};

(function() {

    var Game = Backbone.Model.extend({
      url: "/game.json",
    });

    app.game = new Game();

}());

