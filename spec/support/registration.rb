shared_context 'valid parameters' do

  def register!
    ::Registration.new(params[:registration]).register!
  end

  let(:params) do
    {
      registration:
      {
        user: Fabricate.attributes_for(:org_leader),
        organization: Fabricate.attributes_for(:organization),
        payment: Fabricate.attributes_for(:payment)
      }
    }
  end

end
