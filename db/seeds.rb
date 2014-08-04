require File.expand_path('../../config/environment', __FILE__)

attrs = {
  user: Fabricate.attributes_for(:org_leader),
  organization: Fabricate.attributes_for(:organization),
  payment: Fabricate.attributes_for(:payment)
}

puts '******** Creating Random Registration **********'

Registration.new(attrs).register!

puts '********* Adding Projects to Organization ********'

%w(foo bar baz).each do |name|
  Organization.last.projects.create!(name: name, purpose: 'this is a default purpose for a project')
end
