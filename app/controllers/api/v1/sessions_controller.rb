class Api::V1::SessionsController < Api::V1::BaseController
  skip_before_action :authenticate_user!
  skip_before_action :verify_authenticity_token

    def create
    user = User.where(email: params[:email]).first

    if user.valid_password?(params[:password])
      sign_in(user)
      if user.type == "Member"
          render json: user, serializer: Api::V1::MembersSerializer,  status: :created  
    
      elsif user.type == "FundRaiser"
          render json: user, serializer: Api::V1::FundRaisersSerializer,  status: :created  
    
      elsif user.type == "Patriot"
          render json: user, serializer: Api::V1::PatriotsSerializer,  status: :created  
    
      elsif user.type == "Champion"
          render json: user, serializer: Api::V1::ChampionsSerializer,  status: :created         
      end
    else
      head :unauthorized
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