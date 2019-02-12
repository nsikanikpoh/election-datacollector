class Api::V1::SessionsController < Api::V1::BaseController
  skip_before_action :authenticate_user!
  skip_before_action :verify_authenticity_token

    def create
    user = User.where(email: params[:email]).first

        if user.valid_password?(params[:password])
           sign_in(user)
    
       
        render :json => user.to_json, :status => 201
       else
         render json: "errors", :status => 422
       end  
  end

  def destroy
    if @current_user
      sing_out(@current_user)

      render json: "sucess", :status => 200
      
    else

      render json: {error: ['Error occurred']}, status: :internal_server_error

    end

  end

end