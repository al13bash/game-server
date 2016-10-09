GameService.instance.update!(revenue_amount_cents: 1_000_000)

CurrencyExchange.instance.update!(usd: 1.1161, rub: 69.7125)

User.create!(
  email: 'admin@example.com',
  password: 'foobar13',
  username: 'adminushka'
) if User.count.zero?
