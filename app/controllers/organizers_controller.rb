class OrganizersController < ApplicationController
    def create
        @organization = Organizer.create!(organization_params)
        flash[:notice] = "Welcome #{@organization.name}!"
        redirect_to events_path
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
          redirect_to new_event_path
        end
      end
    
    
      private
      # Making "internal" methods private is not required, but is a common practice.
      # This helps make clear which methods respond to requests, and which ones do not.
      def organization_params
        params.require(:organization).permit(:name, :email, :password)
      end
    end
    