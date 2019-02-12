class ApplicationController < ActionController::Base
  protect_from_forgery unless: -> { request.format.json? }
  #protect_from_forgery with: :null_session
  #before_action :authenticate_with_token
  before_action :authenticate_user!
  before_action :configure_permitted_parameters, if: :devise_controller?
  #skip_before_action :authenticate_admin!, if: :devise_controller?
  protected
  
  def configure_permitted_parameters
	devise_parameter_sanitizer.permit(:sign_up){|u| u.permit( :first_name, :last_name, :image, :remove_image, :image_cache, :gender, :address,:phone, :email, :password, :remember_me)}
    devise_parameter_sanitizer.permit(:sign_in){|u| u.permit(:email, :password, :remember_me)}
	devise_parameter_sanitizer.permit(:account_update){|u| u.permit( :first_name, :last_name, :image, :remove_image, :image_cache, :gender, :address,:phone, :email, :password, :current_password, :remember_me)}
  end

  private
  
    
  def authenticate_with_token
      if params[:api_token]
        user = User.find_by_api_token(params[:api_token])
        sign_in(user)
      end
  end


    

end