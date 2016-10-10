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
    var destinationUrl = window.location.origin;

    $.post(destinationUrl + '/games', { game: data });
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
      case 'validation_failed':
        this.updateGameStatus(data.game_id, data.game_status);
        this.addGameErrorMessage(data.game_id, data.message);
        break;
      case 'transaction_in_progress':
        this.updateGameStatus(data.game_id, data.game_status);
        break;
      case 'transaction_completed':
        this.updateGameInTable(data.game_id, data.game_partial);
        this.updateAccountsSelect(data.accounts);
        this.updateAccountsList(data.accounts);
        break;
      default:
        console.log('default')
    }
  },
  resetForm: function() {
    $('form.new-game-form').get(0).reset();
  },
  addGameToTable: function(partial) {
    $('.game-table tbody').prepend(partial);
  },
  addGameErrorMessage: function(id, message) {
    var $tag = $('<span class="tag tag-danger">' + message + '</span><br>');

    $('.game-row-' + id).find('.win-col').append($tag);
  },
  updateGameInTable: function(id, partial) {
    $('.game-row-' + id).replaceWith(partial);
  },
  updateGameStatus: function(id, status) {
    var $tag = $('.game-row-' + id).find('.status-col span');

    $tag
      .removeClass()
      .addClass('tag tag-' + this.tagClass(status))
      .text(status);
  },
  updateAccountsList: function(accounts) {
    var $accountsList = $('.accounts-list');

    $.each(accounts, function(index, account) {
      $accountsList.find('.account-' + index).text(account.amount);
    });
  },
  updateAccountsSelect: function(accounts) {
    var $accountsSelect = $('.accounts-select');

    $.each(accounts, function(index, account) {
      $accountsSelect
        .find('.account-' + index)
        .text(account.amount_currency + ' - (Balance: ' + account.amount + ')');
    });
  },
  tagClass: function(status) {
    switch (status) {
      case 'pending':
        return 'info';
      case 'in_validation':
        return 'warning';
      case 'in_progress':
        return 'primary';
      case 'done':
        return 'success';
      case 'failure':
        return 'danger';
      default:
        return 'default';
    }
  }
});
