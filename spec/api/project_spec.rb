require 'spec_helper'

describe Crosscourt::API do

  def app
    Crosscourt::API
  end

  describe 'Project' do

    describe 'POST /api/project' do
      include_context "with existing account"

      context 'with proper parameters' do


        it 'creates a new project' do
          pending
        end
      end
    end
  end
end
