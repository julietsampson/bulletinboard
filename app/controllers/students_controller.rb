class StudentsController < ApplicationController
  
    def show
      id = params[:id] # retrieve event ID from URI route
      @student = Student.find(id) # look up event by unique ID
      @all_tags = Student.all_tags
      @tags_to_show = @student.tags
      # will render app/views/events/show.<extension> by default
    end

    def create
      @existing_student = Student.find_by(uni: params[:student][:uni])
      if (params[:student][:uni] == "" || params[:student][:name] == "" || params[:student][:password] == "")
        flash[:notice] = "Please fill out all of the fields."
        redirect_to root_path
      elsif (@existing_student != nil)
        flash[:notice] = "An account with this UNI already exists. Please login instead. "
        redirect_to root_path
      else
        @student = Student.create!(student_params)
        flash[:notice] = "Welcome #{@student.name}!"
        session[:student_id] = @student.id
        redirect_to events_path
      end
    end
  
    def login
      @student = Student.find_by(uni: params[:student][:uni])
      if (@student == nil)
        flash[:notice] = "User not found-- please create an account!"
        redirect_to root_path
      elsif (@student.password != params[:student][:password])
        flash[:notice] = "Password incorrect. Please try again!"
        redirect_to root_path()
      else
        flash[:notice] = "Welcome back #{@student.name}!"
        session[:student_id] = @student.id
        redirect_to events_path
      end
    end

    def add_event
      @student = Student.find(session[:student_id])
      @event = Event.find(params[:id])
      if (@student.events.include?(@event))
        flash[:notice] = "You've already added #{@event.name} to your list!"
        redirect_to events_path
        return
      end
      @student.events << @event
      redirect_to student_events_path('student_id': @student.id)
    end

    def remove_event
      @student = Student.find(session[:student_id])
      @event = Event.find(params[:id])
      @student.events.delete(@event)
      redirect_to student_events_path('student_id': @student.id)
    end

    def my_events
      @student = Student.find(session[:student_id])
      @events = @student.events
    end

    def update
      @student = Student.find(params[:id])
      tags_array = []
      if (params[:tags])
        params_array = params[:tags].keys
        for tag in params_array
          tags_array.append(tag)
        end
      end
      @student.update(:tags => tags_array)
      flash[:notice] = "You successfully updated your profile."
      redirect_to student_profile_path(@student)
    end
  
  
    private
    # Making "internal" methods private is not required, but is a common practice.
    # This helps make clear which methods respond to requests, and which ones do not.
    def student_params
      params.require(:student).permit(:name, :uni, :password)
    end
  end
  