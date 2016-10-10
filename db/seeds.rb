GameService.instance.update!(revenue_amount_cents: 1_000_000)

CurrencyExchange.instance.update!(usd: 1.1161, rub: 69.7125)

User.create!(
  email: 'admin@example.com',
  password: 'foobar13',
  username: 'adminushka'
) if User.count.zero?

errors_messages = [
  {
    kind: :min_bet_amount_is_not_reached,
    message: "Min bet amount is not reached"
  },
  {
    kind: :max_bet_amount_exceeded,
    message: "Max bet amount exceeded"
  },
  {
    kind: :insufficient_funds_in_account,
    message: "Insufficient funds in the account"
  },
  {
    kind: :user_in_blacklist,
    message: "User in blacklist"
  },
  {
    kind: :validation_failed,
    message: "Validation failed"
  }
]

errors_messages.each{ |error| AppError.create(error) }
