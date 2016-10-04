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

      // convert units to subunits
      formData['bet_amount_cents'] *= 100;

      that.createGame(formData);
      that.resetForm();
    });
  },
  createGame: function(data) {
    $.post('/games', { game: data });
  },
  disconnected: function(data) {
    console.log('disconnected', data);
  },
  rejected: function(data) {
    console.log('rejected', data);
  },
  received: function(data) {
    console.log('received', data);
    var status = data.status;

    switch (status) {
      case 'game_created':
        this.addGameToTable(data.game_partial);
        break;
      case 'transaction_in_progress':
        this.updateGameInTable(data.game_id, data.game_partial);
        break;
      case 'transaction_completed':
        this.updateGameInTable(data.game_id, data.game_partial);
        this.updateAccountsSelect(data.accounts_select);
        this.updateAccountsList(data.accounts_list);
        break;
      default:
        console.log('default')
    }
  },
  resetForm() {
    $('form.new-game-form').get(0).reset();
  },
  addGameToTable: function(partial) {
    $('.game-table tbody').prepend(partial);
  },
  updateGameInTable: function(id, partial) {
    $('.game-row-' + id).replaceWith(partial);
  },
  updateAccountsList: function(list) {
    $('.accounts-list').replaceWith(list);
  },
  updateAccountsSelect: function(select) {
    $('.accounts-select').replaceWith(select);
  }
});
