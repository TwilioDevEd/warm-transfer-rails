require 'rails_helper'

RSpec.describe HomeController, type: :controller do
  describe 'GET #index' do
    subject { get :index }

    it 'renders the index template' do
      expect(subject).to render_template(:index)

      expect(response).to be_ok
    end
  end
end
