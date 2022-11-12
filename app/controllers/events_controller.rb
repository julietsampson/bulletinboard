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
    id = session[:student_id]
    @student = Student.find(id)
    @events = Event.all
  end

  def organizer_index
    @events = Event.where(organizer_id: params[:organizer_id])
  end

  def new
    # default: render 'new' template
    @all_tags = Event.all_tags
    @tags_to_show = []
  end

  # def create
  #   @event = Event.create!(event_params)
  #   flash[:notice] = "#{@event.name} was successfully created."
  #   redirect_to organizer_events_path
  # end

  def create
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

  def edit
    @event = Event.find params[:id]
    @all_tags = Event.all_tags
    @tags_to_show = @event.tags
  end

  def update
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
end
