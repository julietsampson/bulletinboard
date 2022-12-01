class PagesController < ApplicationController
    def index
      session[:user_id] = ""
      session[:organizer_id] = ""
    end
  
  end