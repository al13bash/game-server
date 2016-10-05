Fabricator(:user) do
  username Faker::Name.name
  email { Faker::Internet.email }
  password 'password'
  games(count: 1)
  accounts(count: 1)
end
