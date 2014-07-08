class NonBlank < Grape::Validations::Validator
  def validate_param!(attr_name, params)
    if params[attr_name].blank?
      raise Grape::Exceptions::Validation, param: @scope.full_name(attr_name), message: "cannot be blank"
    end
  end
end
