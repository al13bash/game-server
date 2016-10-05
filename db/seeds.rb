# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

GameService.instance.update(revenue_amount_cents: 1_000_000)

CurrencyExchange.instance.update(usd: 1.1161, rub: 69.7125)
