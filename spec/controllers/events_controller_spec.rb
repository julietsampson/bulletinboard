require 'rails_helper'

describe EventsController do
    test_event = Event.create(:name => "spec testing event", :tags => ["STEM"])
    test_org = Organizer.find_by(:email => "spectestorg@gmail.com")
    if (test_org == nil)
      test_org = Organizer.create(:name => "spec testing organizer",  :email => "spectestorg@gmail.com", :password => "pass")
    end
    test_org.events << test_event

    student = Student.find_by(:uni => "sk4699")
    if (student == nil)
        student = Student.create({name: "sk", uni: "sk4699", password: "password"})
    end

    describe 'GET index' do
        it 'should render the index template' do
          request.session[:student_id] = student.id
          get :index
          expect(response).to render_template('index')
        end
        it 'should only show events that the student is free for if requested' do
          d = Date.new(1996,1,2)
          start_datetime = DateTime.new(d.year, d.month, d.day, 9, 30)
          end_datetime = DateTime.new(d.year, d.month, d.day, 12, 30)
          good_datetime = DateTime.new(d.year, d.month, d.day, 8, 30)
          bad_datetime = DateTime.new(d.year, d.month, d.day, 10, 30)
          event1 = Event.create(:name => "convenient", :datetime => good_datetime)
          event2 = Event.create(:name => "inconvenient", :datetime => bad_datetime)
          student.timeblocks.create(busy_range: (start_datetime..end_datetime))
          student.update!(:tags => ["When I'm Free"])
          student.reload
          request.session[:student_id] = student.id
          get :index, params: {tags: {"When I'm Free" => 1}}
          assigns(:events).should eq([event1])
          expect(response).to render_template('index')
        end
    end

    describe 'GET new' do
      it 'should render the new template with all tags showing' do
        get :new
        expect(response).to render_template('new')
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
        it 'does not update an event without the required fields completed' do
          new_event = Event.create(:name => "test event")
          new_attr = {:name => "", :location => 'Butler'}
          put :update, params: {id: new_event.id, event: new_attr, tags: {"Sophomore" => 1, "Humanities" => 1}}
          new_event.reload
          expect(new_event.location).to_not eq('Butler')
          expect(new_event.tags).to_not eq(["Humanities", "Sophomore"])
        end
        it 'saves an event\'s updated details' do
            new_event = Event.create(:name => "test event")
            new_attr = {:location => 'Butler'}
            put :update, params: {id: new_event.id, event: new_attr, tags: {"Sophomore" => 1, "Humanities" => 1}}
            new_event.reload
            expect(new_event.location).to eq('Butler')
            expect(new_event.tags).to eq(["Humanities", "Sophomore"])
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
        it 'refuses to create an event without the required fields completed' do
          request.session[:organizer_id] = Organizer.first.id
          expect {post :create, params: {event: {name: ""}, tags: {"Freshman" => 1, "STEM" => 1}}}.to change {Event.count}.by(0)
        end
        it 'creates a new event when all required fields are completed' do
          request.session[:organizer_id] = Organizer.first.id
          expect {post :create, params: {event: {name: "New event"}, tags: {"Freshman" => 1, "STEM" => 1}}}.to change {Event.count}.by(1)
        end
    end
    
    describe 'DELETE #destroy' do
        # byebug
        it 'destroys movie' do
          request.session[:organizer_id] = test_org.id
          expect {delete :destroy, params: {id: test_org.events.first.id}}.to change{Event.count}.by(-1)
        end
    end

    describe 'best_scheduling options works as intended' do
      Timeblock.delete_all
      Student.delete_all
      student = Student.create({name: "sk", uni: "sk4699_tag_test", password: "password", tags: ["Freshman", "STEM"]})
      student2 = Student.create({name: "sv", uni: "sv2611_tag_test", password: "password", tags: ["Sophomore", "STEM"]})
      student = Student.find_by(:uni => "sk4699_tag_test")
      # if (student == nil)
      #   student = Student.create({name: "sk", uni: "sk4699_tag_test", password: "password", tags: ["Freshman", "STEM"]})
      # end
      # student2 = Student.find_by(:uni => "sv2611_tag_test")
      # if (student2 == nil)
      #   student2 = Student.create({name: "sv", uni: "sv2611_tag_test", password: "password", tags: ["Sophomore", "STEM"]})
      # end
      d = Date.new(1996,1,2)
      start_datetime = DateTime.new(d.year, d.month, d.day, 9, 30)
      end_datetime = DateTime.new(d.year, d.month, d.day, 12, 30)
      student.timeblocks.create(busy_range: (start_datetime..end_datetime))
      
       it 'finds the appropriate scheduling options' do
        controller = EventsController.new
        result = controller.send(:best_scheduling_options, test_event[:tags])
        expect(result).to eq({:first => {:day => "Monday", :hour => 8, :num_available => 2}, :second => {:day => "Monday", :hour => 9, :num_available => 2}, :third => {:day => "Monday", :hour => 13, :num_available => 2}})
      end

      it 'uses the appropriate day date map' do
        controller = EventsController.new
        appropriate_map = {:mon => "01-Jan-1996 ", :tue => "02-Jan-1996 ", :wed => "03-Jan-1996 ", :thu => "04-Jan-1996 ", :fri => "05-Jan-1996 ", :sat => "06-Jan-1996 ", :sun => "07-Jan-1996 "}
        result = controller.send(:day_date_mapping)
        expect(result).to eq(appropriate_map)
      end
    end
end