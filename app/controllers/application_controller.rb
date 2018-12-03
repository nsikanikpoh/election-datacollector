class ApplicationController < ActionController::Base
  protect_from_forgery unless: -> { request.format.json? }
  #protect_from_forgery with: :null_session
  #before_action :authenticate_with_token
  before_action :authenticate_user!
  before_action :onemilmap_home
  before_action :set_referrer
  before_action :perform_upgrade 
  before_action :configure_permitted_parameters, if: :devise_controller?
  #skip_before_action :authenticate_admin!, if: :devise_controller?
  protected
  
  def configure_permitted_parameters
	devise_parameter_sanitizer.permit(:sign_up){|u| u.permit(:referrer_code, :image, :birthday, :remove_image, :image_cache, :title, :type, :name, :gender, :address,:phone, :state,:location, :email, :password, :remember_me)}
    devise_parameter_sanitizer.permit(:sign_in){|u| u.permit(:email, :password, :remember_me)}
	devise_parameter_sanitizer.permit(:account_update){|u| u.permit(:image, :birthday, :remove_image, :image_cache, :title, :name, :gender, :address,:phone, :state,:location,:email, :password, :current_password, :remember_me)}
  end

  private
  
  def set_referrer
  # Just store this for later, we will check this out during checkout
      cookies[:referrer_code] = {value: params[:referrer_code], expiry: 90.days.from_now} if params[:referrer_code] && !user_signed_in?
  end

  
  
  def authenticate_with_token
      if params[:api_token]
        user = User.find_by_api_token(params[:api_token])
        sign_in(user)
      end
  end

   def onemilmap_home
      @posts = Post.all
      @collages = Collage.all
    end

    def perform_upgrade
      members = Member.all
      amount = 0
      one_year_donations ||= []
      members.each do |f|
          if f.donations.any?
            all_donations = f.donations
            all_donations.each do |d|
                if d.created_at <= (d.created_at + 1.year)
                  one_year_donations.push(d)
                end
            end
           if one_year_donations.any?
              one_year_donations.each do |s|
                  amount += s.amount
              end
            end

            if amount >= 24000
              f.update(type: "Patriot", s_type: "Patriot")
            elsif amount >= 2000 
              f.update(type: "Champion", s_type: "Champion")                   
            end
    
          end
      end

    end

end