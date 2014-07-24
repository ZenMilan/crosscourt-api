Fabricator(:user, from: Crosscourt::Registration::User) do
  first_name { Faker::Name.first_name }
  last_name { Faker::Name.last_name }
  email { |attrs| Faker::Internet.safe_email(attrs[:first_name]) }
  password { Faker::Internet.password(5) }
end

Fabricator(:org_leader, from: :user) do
  type 'OrganizationLeader'
end
