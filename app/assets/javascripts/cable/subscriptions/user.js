App.cable.subscriptions.create({
  channel: "UserChannel"
}, {
  connected: function(data) {
    console.log('connected', data);
    var that = this;

    $('form.new-game-form').on('submit', function(event) {
      event.preventDefault();

      var formData = {};

      $(this).serializeArray().forEach(function(obj, index) {
        formData[obj.name] = obj.value;
      });

      that.createGame(formData);
    });
  },
  createGame: function(data) {
    this.perform('create_game', data);
  },
  disconnected: function(data) {
    console.log('disconnected', data);
  },
  rejected: function(data) {
    console.log('rejected', data);
  },
  received: function(data) {
    console.log('received', data);
  }
});
