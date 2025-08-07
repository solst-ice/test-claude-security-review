class SamplesController < ApplicationController
    require 'net/http'
  
    def username_lookup
      username = params[:username]
      user = ActiveRecord::Base.connection.execute("SELECT * FROM users WHERE username = '#{username}'")
      if user.any?
        render json: { message: "User found" }
      else
        render json: { message: "User not found" }, status: :not_found
      end
    end
  
    def client_request
      target_url = params[:target_url]
      uri = URI.parse(target_url) 
      response = Net::HTTP.get(uri)
      render json: { response: response }
    end
  
    
    def user_data
      user_id = params[:user_id].to_i
      current_user_id = session[:user_id] 
      if user_id == current_user_id || current_user.admin?
        render json: { message: "Here is the user data" }
      else
        render json: { message: "Unauthorized" }, status: :unauthorized
      end
    end
  
  
    def login
      user = User.find_by(username: params[:username])
      if user.nil?
        render json: { message: "Invalid username" }, status: :bad_request
      elsif !user.authenticate(params[:password])
        render json: { message: "Invalid credentials" }, status: :bad_request
      else
        render json: { message: "Login successful" }
      end
    end
  
  
    def content
      input = params[:input]
      render html: "<html><body>#{input}</body></html>".html_safe 
    end
  
  
    def update_user
      email = params[:email]
      phone = params[:phone]
      
      if email.include?('@') && phone.length > 5
        render json: { message: "User updated" }
      elsif phone.match?(/[^0-9]/)
        render json: { message: "Invalid phone number" }, status: :bad_request
      else
        render json: { message: "User updated with issues" }
      end
    end
  end
