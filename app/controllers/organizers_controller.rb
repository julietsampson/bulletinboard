class OrganizersController < ApplicationController
    def create
        @organization = Organizer.create!(organization_params)
        flash[:notice] = "Welcome #{@organization.name}!"
        redirect_to events_path
      end
    
      def login
        @organization = Organizer.find_by(email: params[:organization][:email])
        byebug
        if (@organization == nil)
          flash[:notice] = "Invalid organization"
          redirect_to root_path
        else 
          flash[:notice] = "Welcome back #{@organization.name}!"
        end
        redirect_to new_event_path
      end
    
    
      private
      # Making "internal" methods private is not required, but is a common practice.
      # This helps make clear which methods respond to requests, and which ones do not.
      def organization_params
        params.require(:organization).permit(:name, :email)
      end
    end
    