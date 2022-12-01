require 'rails_helper'

describe PagesController do
    describe 'GET index' do
        it 'should render the index template' do
          get :index
          expect(response).to render_template('index')
        end
    end
end