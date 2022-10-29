class StudentsController < ApplicationController
  
    def create
      @student = Student.create!(student_params)
      flash[:notice] = "Welcome #{@student.name}!"
      redirect_to events_path
    end
  
    def login
      @student = Student.find_by(uni: params[:student][:uni])
      if (@student == nil)
        flash[:notice] = "Invalid User"
        redirect_to root_path
      else 
        flash[:notice] = "Welcome back #{@organization.name}!"
      end
      redirect_to events_path
    end
  
  
    private
    # Making "internal" methods private is not required, but is a common practice.
    # This helps make clear which methods respond to requests, and which ones do not.
    def student_params
      params.require(:student).permit(:name, :uni)
    end
  end
  