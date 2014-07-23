Fabricator(:registration) do
  user
  organization
  payment
end

Fabricator(:user) do
  first_name { Faker::Name.first_name }
  last_name { Faker::Name.last_name }
  email { |attrs| Faker::Internet.safe_email(attrs[:first_name]) }
  password { Faker::Internet.password(8) }
end

Fabricator(:organization) do
  name { Faker::Company.name }
end

Fabricator(:payment) do
  details { Faker::Business.credit_card_type }
end
