class PasswordsController < Api::V1::BaseController
	skip_before_action :authenticate_user!
  skip_before_action :verify_authenticity_token

  def create
  	 user = User.where(email: params[:email]).first
  	if  user.id
  		user.send_reset_password_instructions
      		
      	render json: {status: 'success'}, status: :ok
    	
    else

    	render json: {error: ['Error occurred']}, status: :internal_server_error

    end

  end


end