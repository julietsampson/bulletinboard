require 'rails_helper'

describe OrganizersController do
    
    describe 'POST #create' do
        it 'creates a new organizer' do
            expect {post :create, organization: {:name => "New org", :email => "neworg@gmail.com", :password => "password"}}.to change {Organizer.count}.by(1)
        end
    end

    describe 'POST login' do
        organization = Organizer.first
        count = Organizer.count
        it 'should login an existing organization that provides the correct password' do
          post :login, organization: {:email => organization.email, :password => organization.password}
          expect(response).to redirect_to(organizer_events_path('organizer_id': organization.id))
        end

        it 'should not login an organization that provides an incorrect password' do
            post :login, organization: {:email => organization.email, :password => ""}
            expect(response).to redirect_to(root_path)
        end

        it 'should not login an organization that has not created an account' do
            post :login, organization: {:email => "fake@gmail.com", :password => ""}
            expect(response).to redirect_to(root_path)
        end
    end

    describe 'POST logout' do
        it 'should redirect back to the home page do' do
            post :logout
            expect(response).to redirect_to(root_path)
        end
    end
end