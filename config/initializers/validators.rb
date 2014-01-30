class NonBlank < Grape::Validations::Validator
  def validate_param!(attr_name, params)
    if params[attr_name].blank?
      name = attr_name.to_s.humanize
      raise Grape::Exceptions::Validation, param: name, message: "was left blank"
    end
  end
end
