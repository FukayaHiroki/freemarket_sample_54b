require 'rails-helper'

describe Users::RegistrationsController, type: :controller do
  describe 'GET #new' do
    it "render the :new template" do
      get :new
      expect(response).to render_template :new 
    end
  end

end