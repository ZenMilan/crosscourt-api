Fabricator(:payment, from: Crosscourt::Registration::Payment) do
  details { Faker::Business.credit_card_type }
end
