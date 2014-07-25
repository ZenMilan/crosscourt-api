Fabricator(:organization, from: Crosscourt::Registration::Organization) do
  name { Faker::Company.name }
end
