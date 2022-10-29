class OrganizersController < ApplicationController
    def create
        @organization = Organizer.create!(organization_params)
        flash[:notice] = "Welcome #{@organization.name}!"
        redirect_to events_path
    end
    
    def create_event
        @event = @organizer.events.create(event_params)
        redirect to organizer_events_path('organizer_id': @organization.id)
    end
    
    def login
      @organization = Organizer.find_by(email: params[:organization][:email])
      if (@organization == nil)
        flash[:notice] = "Organization not found-- please create an account!"
        redirect_to root_path
      elsif (@organization.password != params[:organization][:password])
        flash[:notice] = "Password incorrect. Please try again!"
        redirect_to root_path
      else 
        flash[:notice] = "Welcome back #{@organization.name}!"
        redirect_to organizer_events_path('organizer_id': @organization.id)
      end
    end
    
    
      private
      # Making "internal" methods private is not required, but is a common practice.
      # This helps make clear which methods respond to requests, and which ones do not.
      def organization_params
        params.require(:organization).permit(:name, :email, :password)
      end

      def event_params
        params.require(:event).permit(:name, :datetime, :location, :description, :tags)
      end
    end
    