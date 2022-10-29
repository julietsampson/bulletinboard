class StudentsController < ApplicationController
  
    def create
      @student = Student.create!(student_params)
      flash[:notice] = "Welcome #{@student.name}!"
      session[:student_id] = @student.id
      redirect_to events_path
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
  
  
    private
    # Making "internal" methods private is not required, but is a common practice.
    # This helps make clear which methods respond to requests, and which ones do not.
    def student_params
      params.require(:student).permit(:name, :uni, :password)
    end
  end
  