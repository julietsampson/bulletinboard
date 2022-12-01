require 'rails_helper'

describe StudentsController do

    student = Student.find_by(:uni => "sk4699")
    if (student == nil)
        student = Student.create({name: "sk", uni: "sk4699", password: "password"})
    end
    
    describe 'POST #create' do
        it 'refuses to create a student without all fields filled out' do
            expect {post :create, params: {create_student: {name: "New student", uni: "", password: ""}}}.to change {Student.count}.by(0)
        end

        it 'creates a new student when given all params, and only if an account with this uni does not already exist' do
            expect {post :create, params: {create_student: {name: "New stud", uni: "XXXX", password: "password"}}}.to change {Student.count}.by(1)
            expect {post :create, params: {create_student: {name: "New student", uni: "XXXX", password: "password"}}}.to change {Organizer.count}.by(0)
        end
    end

    describe 'POST login' do
        student = Student.first
        count = Student.count
        it 'should login an existing student that provides the correct password' do
          post :login, params: {student: {name: student.name, uni: student.uni, password: student.password}}
          expect(response).to redirect_to(events_path)
        end

        it 'should not login a student that provides an incorrect password' do
            post :login, params: {student: {:name => student.name, :uni => student.uni, :password => ""}}
            expect(response).to redirect_to(root_path)
        end

        it 'should not login an student that has not created an account' do
            post :login, params: {student: {:name => student.name, :uni => "fake1234", :password => ""}}
            expect(response).to redirect_to(root_path)
        end
    end

    describe 'POST add_event' do
        event = Event.create(:name => "test event")
        it 'should add an event to the student\'s event list if the event is not already on their list' do
            request.session[:student_id] = Student.first.id
            
            expect {post :add_event, params: {:id => event.id}}.to change {Student.first.events.count}.by(1)
            expect(response).to redirect_to(student_events_path('student_id': Student.first.id))
        end

        it 'should not add an event to a student\'s list if the event is already on their list' do
            event = Student.first.events.create(:name => "tester event")
            request.session[:student_id] = Student.first.id
            expect {post :add_event, params: {:id => event.id}}.to change {Student.first.events.count}.by(0)
            expect(response).to redirect_to(events_path)
        end
    end

    describe 'POST remove_event' do
        event =  Student.first.events.create(:name => "tester event")
        it 'should remove an event from the student\'s event list' do
            request.session[:student_id] = Student.first.id
            expect {post :remove_event, params: {:id => event.id}}.to change {Student.first.events.count}.by(-1)
            expect(response).to redirect_to(student_events_path('student_id': Student.first.id))
        end
    end

    describe 'GET my_events' do
        it 'should render the my_events template' do
          request.session[:student_id] = Student.first.id
          get :my_events
          expect(response).to render_template('my_events')
        end
    end

    describe 'GET show_schedule' do
        it 'should render the show_schedule template' do
            request.session[:student_id] = Student.first.id
            get :show_schedule
            expect(response).to render_template('show_schedule')
        end
    end

    describe 'GET edit_schedule' do
        it 'should render the edit_schedule template' do
            request.session[:student_id] = Student.first.id
            get :edit_schedule
            expect(response).to render_template('edit_schedule')
        end
    end

    describe 'POST update_schedule' do
        d = Date.new(1996,1,1)
        timeblock1 = {:weekday => "Monday", :busy_start => d.beginning_of_day, :busy_end => d.end_of_day}
        timeblock2 = {:weekday => "Tuesday", :busy_start => d.beginning_of_day, :busy_end => d.end_of_day}
        timeblock3 = {:weekday => "Wednesday", :busy_start => d.beginning_of_day, :busy_end => d.end_of_day}
        timeblock4 = {:weekday => "Thursday", :busy_start => d.beginning_of_day, :busy_end => d.end_of_day}
        timeblock5 = {:weekday => "Friday", :busy_start => d.beginning_of_day, :busy_end => d.end_of_day}
        timeblock6 = {:weekday => "Saturday", :busy_start => d.beginning_of_day, :busy_end => d.end_of_day}
        timeblock7 = {:weekday => "Sunday", :busy_start => d.beginning_of_day, :busy_end => d.end_of_day}
        it 'should be able to add a new timeblock to the student\'s schedule for every day of the week' do
            request.session[:student_id] = Student.first.id
            expect {post :update_schedule, params: {:timeblock => timeblock1}}.to change {Student.first.timeblocks.count}.by(1)
            expect {post :update_schedule, params: {:timeblock => timeblock2}}.to change {Student.first.timeblocks.count}.by(1)
            expect {post :update_schedule, params: {:timeblock => timeblock3}}.to change {Student.first.timeblocks.count}.by(1)
            expect {post :update_schedule, params: {:timeblock => timeblock4}}.to change {Student.first.timeblocks.count}.by(1)
            expect {post :update_schedule, params: {:timeblock => timeblock5}}.to change {Student.first.timeblocks.count}.by(1)
            expect {post :update_schedule, params: {:timeblock => timeblock6}}.to change {Student.first.timeblocks.count}.by(1)
            expect {post :update_schedule, params: {:timeblock => timeblock7}}.to change {Student.first.timeblocks.count}.by(1)
            expect(response).to redirect_to(edit_schedule_path())
        end
    end

    describe 'GET remove_timeblock' do
        d = Date.new(1996,1,1)
        start_datetime = DateTime.new(d.year, d.month, d.day, 9, 30)
        end_datetime = DateTime.new(d.year, d.month, d.day, 12, 30)
        Student.first.timeblocks.create(busy_range: (start_datetime..end_datetime))
        it 'should remove a given timeblock from the student\'s schedule' do
            request.session[:student_id] = Student.first.id
            expect {get :remove_timeblock, params: {:id => Student.first.timeblocks.first.id}}.to change {Student.first.timeblocks.count}.by(-1)
            expect(response).to redirect_to(edit_schedule_path())
        end
    end

    describe 'GET student_profile' do
        it 'should render the my_profile template' do
            request.session[:student_id] = Student.first.id
            get :my_profile
            expect(response).to render_template('my_profile')
        end
    end

    describe 'POST student_update' do
        s1 = Student.first
        tags = {"Senior" => 1, "STEM" => 1}
        s1.update!(:tags => ["Senior"])
        s1.reload
        it 'should update the student\'s tags if new ones are provided' do
            request.session[:student_id] = s1.id
            post :update, params: {:id => s1.id, :tags => tags}
            s1.reload
            expect(s1.tags).to eq(['STEM', 'Senior'])
            expect(response).to redirect_to(student_profile_path(s1))
        end
        s1.update!(:tags => ["Senior", "STEM"])
        s1.reload
        it 'should not increase the student\'s tags if no new ones are provided' do
            request.session[:student_id] = s1.id
            post :update, params: {:id => s1.id, :tags => tags}
            s1.reload
            expect(s1.tags).to eq(['STEM', 'Senior'])
            expect(response).to redirect_to(student_profile_path(s1))
        end
    end
end