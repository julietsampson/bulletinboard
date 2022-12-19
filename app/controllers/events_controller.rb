class EventsController < ApplicationController

  def show
    id = params[:id] # retrieve event ID from URI route
    @event = Event.find(id) # look up event by unique ID
    # will render app/views/events/show.<extension> by default
  end

  def student_show
    id = params[:id] # retrieve event ID from URI route
    @event = Event.find(id) # look up event by unique ID
    # will render app/views/events/show.<extension> by default
  end

  def index
    student_id = session[:student_id]
    id = params[:id]
    @student = Student.find(student_id)
    @all_tags = Event.all_tags 
    relevant_events = Event.with_tags(tags_list, sort_by)
    if (tags_list.include?("When I'm Free")== false)
      @events = relevant_events
    else
      @events = []
      for event in relevant_events
        if event.datetime
          free = true
          day = day_order_list[event.datetime.wday]
          for tb in @student.weekday_schedule[day]
            t_str =  day_date_mapping[day] + event.datetime.to_s(:time)
            t = DateTime.parse(t_str)
            if (t.between?(tb[:busy_range].begin, tb[:busy_range].end))
              free = false
              break
            end
          end
          if (free)
            @events.append(event)
          end
        end
      end
    end
    @tags_to_show_hash = tags_hash
    @sort_by = sort_by

    session['tags'] = tags_list
    session['sort_by'] = @sort_by
  end

  def tags_list
    params[:tags]&.keys || session[:tags] || Event.all_tags
  end
  def tags_hash
     Hash[tags_list.collect { |item| [item, "1"] }]
  end
  def sort_by
    params[:sort_by] || session[:sort_by] || 'id'
  end

  def organizer_index
    @events = Event.where(organizer_id: params[:organizer_id])
  end

  def new
    # default: render 'new' template
    @all_tags = Event.all_tags
    @tags_to_show = []
  end

  def create
    if params[:event][:name] && params[:event][:name].empty?
      flash[:notice] = "Please fill in the required fields."
      redirect_to new_event_path
    else
      tags_array = []
      if (params[:tags])
        params_array = params[:tags].keys
        for tag in params_array
          tags_array.append(tag)
        end
      end
      attributes = event_params.clone
      attributes[:tags] = tags_array
      @organizer = Organizer.find_by(id: session[:organizer_id])
      @event = @organizer.events.create(attributes)
      flash[:notice] = "#{@event.name} was successfully created."
      redirect_to organizer_events_path('organizer_id': @organizer.id)
    end
  end

  def edit
    @event = Event.find params[:id]
    @all_tags = Event.all_tags
    @tags_to_show = @event.tags
    relevant_tags = @tags_to_show - ["Free Food"]
    @total_students = Student.where('tags && array[?]', relevant_tags).count
    @scheduling_options = best_scheduling_options(relevant_tags)
  end

  def update
    if params[:event][:name] && params[:event][:name].empty?
      flash[:notice] = "Please fill in the required fields."
      redirect_to edit_event_path(params[:id])
    else
      tags_array = []
      if (params[:tags])
        params_array = params[:tags].keys
        for tag in params_array
          tags_array.append(tag)
        end
      end
      attributes = event_params.clone
      attributes[:tags] = tags_array
      @event = Event.find params[:id]
      @event.update(attributes)
      flash[:notice] = "#{@event.name} was successfully updated."
      redirect_to event_path(@event)
    end
  end

  def destroy
    @organizer = Organizer.find_by(id: session[:organizer_id])
    @event = Event.find(params[:id])
    @event.destroy
    flash[:notice] = "Event '#{@event.name}' deleted."
    redirect_to organizer_events_path('organizer_id': @organizer.id)
  end

  

  private
  # Making "internal" methods private is not required, but is a common practice.
  # This helps make clear which methods respond to requests, and which ones do not.
  def event_params
    params.require(:event).permit(:name, :datetime, :location, :description, :tags)
  end

  def best_scheduling_options(relevant_tags)
    relevant_students = Student.where('tags && array[?]', relevant_tags)
    sched_map = {:mon => Array.new(15, 0), :tue => Array.new(15, 0), :wed => Array.new(15, 0), :thu => Array.new(15, 0), :fri => Array.new(15, 0), :sat => Array.new(15, 0), :sun => Array.new(15, 0)}
    for student in relevant_students
      for day in student.weekday_schedule.keys
        for hour in 1..15 do
          free = true
          for tb in student.weekday_schedule[day]
            t_str =  day_date_mapping[day] + (hour + 7).to_s + ":0-:00 +0"
            t = DateTime.parse(t_str)
            if (t.between?(tb[:busy_range].begin, tb[:busy_range].end))
              free = false
              break
            end
          end
          if (free)
            sched_map[day][hour - 1] += 1
          end
        end
      end
    end

    best_three = {:first => {:day => "", :hour => -1, :num_available => -1}, :second => {:day => "", :hour => -1, :num_available => -1}, :third => {:day => "", :hour => -1, :num_available => -1}}
    for day in sched_map.keys
      for hour in 1..15 do
        if (sched_map[day][hour - 1] > best_three[:first][:num_available])
          best_three[:first][:day] = day_abbrev_map[day]
          best_three[:first][:hour] = hour + 7
          best_three[:first][:num_available] = sched_map[day][hour - 1]
        elsif (sched_map[day][hour - 1] > best_three[:second][:num_available])
          best_three[:second][:day] = day_abbrev_map[day]
          best_three[:second][:hour] = hour + 7
          best_three[:second][:num_available] = sched_map[day][hour - 1]
        elsif (sched_map[day][hour - 1] > best_three[:third][:num_available])
          best_three[:third][:day] = day_abbrev_map[day]
          best_three[:third][:hour] = hour + 7
          best_three[:third][:num_available] = sched_map[day][hour - 1]
        end
      end
    end
    return best_three
  end

  def day_abbrev_map
    {:mon => "Monday", :tue => "Tuesday", :wed => "Wednesday", :thu => "Thursday", :fri => "Friday", :sat => "Saturday", :sun => "Sunday"}
  end

  def day_order_list
    [:sun, :mon, :tue, :wed, :thu, :fri, :sat]
  end

  def day_date_mapping
    {:mon => "01-Jan-1996 ", :tue => "02-Jan-1996 ", :wed => "03-Jan-1996 ", :thu => "04-Jan-1996 ", :fri => "05-Jan-1996 ", :sat => "06-Jan-1996 ", :sun => "07-Jan-1996 "}
  end 
  
end
