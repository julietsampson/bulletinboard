require 'rails_helper'

describe EventsController do
    test_event = Event.create(:name => "spec testing event")
    test_org = Organizer.create(:name => "spec testing organizer",  :email => "spectestorg@gmail.com", :password => "pass")
    test_org.events << test_event

    describe 'GET index' do
        it 'should render the index template' do
          get :index
          expect(response).to render_template('index')
        end
    end
    
    describe 'GET edit' do
        it 'show the details for the right event' do
            new_event = Event.create(:name => "test event")
            get :edit, params: {id: new_event.id}
            assigns(:event).should eq(new_event)
        end
    end

    describe 'POST update' do
        it 'saves an event\'s updated details' do
            new_event = Event.create(:name => "test event")
            new_attr = {:location => 'Butler'}
            put :update, params: {id: new_event.id, event: new_attr}
            new_event.reload
            expect(new_event.location).to eq('Butler')
        end
    end
      
    describe 'GET show' do
        it 'should render the show template' do
          get :show, params: {id: Event.first.id.to_s}
          expect(response).to render_template('show')
        end
    end

    describe 'GET student_show' do
        it 'should render the student_show template' do
          get :student_show, params: {id: Event.first.id.to_s}
          expect(response).to render_template('student_show')
        end
    end
    
    describe 'GET organizer_index' do
        it 'should render the organizer_index template' do
          get :organizer_index, params: {id: Organizer.first.id.to_s}
          expect(response).to render_template('organizer_index')
        end
    end

    describe 'POST #create' do
        it 'creates a new event' do
          request.session[:organizer_id] = Organizer.first.id
          expect {post :create, params: {event: {name: "New event"}}}.to change {Event.count}.by(1)
        end
    end
    
    describe 'DELETE #destroy' do
        # byebug
        it 'destroys movie' do
          request.session[:organizer_id] = test_org.id
          expect {delete :destroy, params: {id: test_org.events.first.id}}.to change{Event.count}.by(-1)
        end
    end
end