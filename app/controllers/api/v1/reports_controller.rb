class Api::V1::ReportsController < Api::V1::BaseController
 #skip_before_action :authenticate_user!, only: [:create]
  #skip_before_action :verify_authenticity_token
  #before_action :set_user, only: [:show, :edit, :update, :destroy]
   #before_action :authenticate_with_token!, only: [:update, :destroy]
   
  # GET /users
  # GET /users.json
def council_wards
  @wards = CouncilWard.all
  @units = PollingUnit.all

  render json: {
    council_wards: @wards, each_serializer: Api::V1::CouncilWardsSerializer, 
    polling_units: @units, each_serializer: Api::V1::PollingUnitsSerializer,
    }
end


#generate all affiliations  of current_user

  def referral_gen(user)
     referrals = user.referrals.to_a
     return referrals
  end

  # POST /users
  # POST /users.json
def create
    @report = Report.new(user_params)
    @report.user = @current_user
      if @report.save
       
           render json: @report, serializer: Api::V1::ReportsSerializer, :status => 201
       else
         render json: "errors", :status => 422
       end    
 end
  # PATCH/PUT /users/1
  # PATCH/PUT /users/1.json
  def update
    user=User.find(params[:id])

    if params[:user][:image] != ''

        uploaded_io = params[:user][:image]
        metadata = "data:image/jpeg;base64,"
        base64_string = uploaded_io[metadata.size..-1]
        blob = Base64.decode64(base64_string)
        image = MiniMagick::Image.read(blob)
        image.size 48763

        # Save in other format
        image.format 'png'
        image.write user.affiliate_code.to_s+'image.png'
        user.update(image: image)
   end
    user.update(name: params[:user][:name], phone: params[:user][:phone], state:params[:user][:state], location: params[:user][:location])
 
      if  user.update(name: params[:user][:name], phone: params[:user][:phone], state:params[:user][:state], location: params[:user][:location])
          render json: user,serializer: Api::V1::UserSerializer, :status => 201
       else
        render :json => user.errors, status: :unprocessable_entity 
       end
  
  end

  # DELETE /users/1
  # DELETE /users/1.json
  def destroy
    current_user.destroy
    head 204
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user
      user = User.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def user_params
      params.require(:report).permit!
    end
end