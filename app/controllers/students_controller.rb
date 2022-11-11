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

    def my_profile
      @student = Student.find(session[:student_id])
    end

    def show_schedule
      @student = Student.find(session[:student_id])
      @schedule = @student.weekday_schedule  # gets hash with day of the week as key and list of time ranges as values
    end

    def edit_schedule
      @student = Student.find(session[:student_id])
      @schedule = @student.weekday_schedule
    end

    def update_schedule
      @student = Student.find(session[:student_id])
      weekday = timeblock_params[:weekday]
      start_hour = timeblock_params["busy_start(4i)"]
      start_min = timeblock_params["busy_start(5i)"]
      end_hour = timeblock_params["busy_end(4i)"]
      end_min =  timeblock_params["busy_end(5i)"]
      if weekday == "Monday"
        d = Date.new(1996,1,1)
      elsif weekday == "Tuesday"
        d = Date.new(1996,1,2)
      elsif weekday == "Wednesday"
        d = Date.new(1996,1,3)
      elsif weekday == "Thursday"
        d = Date.new(1996,1,4)
      elsif weekday == "Friday"
        d = Date.new(1996,1,5)
      elsif weekday == "Saturday"
        d = Date.new(1996,1,6)
      else
        d = Date.new(1996,1,7)
      end
      start_datetime = DateTime.new(d.year, d.month, d.day, start_hour.to_i, start_min.to_i)
      end_datetime = DateTime.new(d.year, d.month, d.day, end_hour.to_i, end_min.to_i)
      @student.timeblocks.create(busy_range: (start_datetime..end_datetime))
      # convert this to start and end time on those dates, save it as a datetime range create new timeblock for student
      flash[:notice] = "Schedule was successfully updated."
      redirect_to edit_schedule_path()
    end

    def remove_timeblock
      @student = Student.find(session[:student_id])
      @timeblock = @student.timeblocks.find(params[:id])
      @student.timeblocks.delete(@timeblock)
      redirect_to edit_schedule_path()
    end
  
    private
    # Making "internal" methods private is not required, but is a common practice.
    # This helps make clear which methods respond to requests, and which ones do not.
    def student_params
      params.require(:student).permit(:name, :uni, :password)
    end

    def timeblock_params
      params.require(:timeblock).permit(:weekday, :busy_start, :busy_end)
    end
  end
  