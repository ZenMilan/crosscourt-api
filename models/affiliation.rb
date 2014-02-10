class Affiliation < ActiveRecord::Base
  TYPES = {
    organization: "OrganizationAffiliation",
    project: "ProjectAffiliation"
  }
end
