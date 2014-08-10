module RegistrationErrors; class ValidationError < StandardError; end; end

class Registration
  include Virtus.model

  attribute :user, Crosscourt::Registration::User
  attribute :organization, Crosscourt::Registration::Organization
  attribute :payment, Crosscourt::Registration::Payment

  def register!
    if self[:user].valid? && self[:organization].valid? && self[:payment].valid?
      persist!
    else
      [:user, :organization, :payment].each do |model|
        fail_registration(self[model]) if self[model].errors.any?
      end
    end
  end

  def fail_registration(model, msg = 'registration error')
    model.errors.messages.each { |k, v| msg = "#{k} #{v.first}" }
    fail RegistrationErrors::ValidationError.new msg
  end

private

  def persist!
    @user = create_user!
    @org = create_org!
    create_payment!
    { user: @user }
  end

  def create_user!
    User::TYPES[:organization_leader].constantize.create!(user.attributes.merge(password_confirmation: user.password))
  end

  def create_org!
    @user.organizations.create!(organization.attributes.merge(org_name: organization.name.downcase))
  end

  def create_payment!
    @org.create_payment!(payment.attributes)
  end
end
