Fabricator(:registration) do
  user { Fabricate(:org_leader) }
  organization
  payment
end
