require 'rails_helper'

describe StudentsController do
    
    describe 'POST #create' do
        it 'creates a new student' do
            expect {post :create, params: {student: {name: "New student", uni: "ns1234", password: "password"}}}.to change {Student.count}.by(1)
        end
    end

    describe 'POST login' do
        student = Student.first
        count = Student.count
        it 'should login an existing student that provides the correct password' do
          post :login, params: {student: {uni: student.uni, password: student.password}}
          expect(response).to redirect_to(events_path)
        end

        it 'should not login a student that provides an incorrect password' do
            post :login, params: {student: {:uni => student.uni, :password => ""}}
            expect(response).to redirect_to(root_path)
        end

        it 'should not login an student that has not created an account' do
            post :login, params: {student: {:uni => "fake1234", :password => ""}}
            expect(response).to redirect_to(root_path)
        end
    end

    describe 'POST add_event' do
        event = Event.create(:name => "test event")
        it 'should add an event to the student\'s event list if the event is not already on their list' do
            request.session[:student_id] = 1
            
            expect {post :add_event, params: {:id => event.id}}.to change {Student.first.events.count}.by(1)
            expect(response).to redirect_to(student_events_path('student_id': 1))
        end

        it 'should not add an event to a student\'s list if the event is already on their list' do
            event = Student.first.events.create(:name => "tester event")
            request.session[:student_id] = 1
            expect {post :add_event, params: {:id => event.id}}.to change {Student.first.events.count}.by(0)
            expect(response).to redirect_to(events_path)
        end
    end

    describe 'POST remove_event' do
        event =  Student.first.events.create(:name => "tester event")
        it 'should remove an event from the student\'s event list' do
            request.session[:student_id] = 1
            expect {post :remove_event, params: {:id => event.id}}.to change {Student.first.events.count}.by(-1)
            expect(response).to redirect_to(student_events_path('student_id': 1))
        end
    end

    describe 'GET my_events' do
        it 'should render the my_events template' do
          request.session[:student_id] = 1
          get :my_events
          expect(response).to render_template('my_events')
        end
    end
end