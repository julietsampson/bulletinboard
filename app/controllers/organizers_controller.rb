class OrganizersController < ApplicationController
    def create
      @existing_org = Organizer.find_by(email: params[:create_organization][:email])
      if (params[:create_organization][:name] == "" || params[:create_organization][:email] == "" || params[:create_organization][:password] == "")
        flash[:notice] = "Please fill out all of the fields."
        redirect_to root_path
      elsif (@existing_org != nil)
        flash[:notice] = "An account with this UNI already exists. Please login instead. "
        redirect_to root_path
      else
        @organization = Organizer.create!(organization_params)
        flash[:notice] = "Welcome #{@organization.name}!"
        session[:organizer_id] = @organization.id
        redirect_to organizer_events_path('organizer_id': @organization.id)
      end
    end
    
    def logout
      reset_session
      redirect_to root_path
    end
    
    def login
      @organization = Organizer.find_by(email: params[:organization][:email])
      if (@organization == nil)
        flash[:notice] = "Organization not found-- please create an account!"
        redirect_to root_path
      elsif (@organization.name != params[:organization][:name] || @organization.password != params[:organization][:password])
        flash[:notice] = "Username or password incorrect. Please try again!"
        redirect_to root_path
      else 
        flash[:notice] = "Welcome back #{@organization.name}!"
        session[:organizer_id] = @organization.id
        redirect_to organizer_events_path('organizer_id': @organization.id)
      end
    end
    
    
      private
      # Making "internal" methods private is not required, but is a common practice.
      # This helps make clear which methods respond to requests, and which ones do not.
      
      def organization_params
        params.require(:create_organization).permit(:name, :email, :password)
      end
    end
    