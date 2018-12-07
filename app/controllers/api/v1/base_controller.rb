class Api::V1::BaseController < ApplicationController
  before_action :authenticate_user!

 rescue_from ActiveRecord::RecordNotFound, with: :not_found

  def not_found
    return api_error(status: 404, errors: 'Not found')
  end

 
  def authenticate_user!
     
      if params[:token]
        user = User.find_by_token(params[:token])
        sign_in(user) unless user
        @current_user = user
      else
         respond_to do |format|
        format.json do
            render json: { error: 'Not Authorized' }, status: 401
        end
      end
        
      end
  end



end

