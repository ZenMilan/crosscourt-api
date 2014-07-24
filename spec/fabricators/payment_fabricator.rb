Fabricator(:payment) do
  details { Faker::Business.credit_card_type }
end
