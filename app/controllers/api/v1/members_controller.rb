class Api::V1::MembersController < Api::V1::BaseController
  skip_before_action :authenticate_user!, only: [:create]
  skip_before_action :verify_authenticity_token
  before_action :set_user, only: [:show, :edit, :update, :destroy]
  respond_to :json
   #before_action :authenticate_with_token!, only: [:update, :destroy]
   
  # GET /users
  # GET /users.json
  
   def index
    users = User.all

    render json: users, each_serializer: Api::V1::UsersSerializer
  end

  # GET /users/1
  # GET /users/1.json
   def show
     if user
        render json: user,serializer: Api::V1::MembersSerializer, :status => 201
       else
         render json: "errors", :status => 422
       end  
  end

def getGender(user)
    if user.gender == "Female"
          return 2
        elsif user.gender == "Male"
          return 1
        end
end
def geo_zone(state)
  north_central = ["Benue","FCT","Kogi","Kwara","Nassarawa","Niger","Plateau"]
  north_east = ["Adamawa","Bauchi","Borno","Gombe","Taraba","Yobe"]
  north_west = ["Jigawa","Kaduna","Kano","Katsina","Kebbi","Sokoto","Zamfara"]
  south_south = ["Akwa Ibom","Bayelsa","Cross River","Delta","Edo","Rivers"]
  south_east = ["Abia","Anambra","Ebonyi","Enugu","Imo"]
  south_west = ["Ekiti","Lagos","Ogun","Ondo","Osun","Oyo",]
       if north_central.include?(state)
          return 100000000
        elsif north_east.include?(state)
          return 100000001
        elsif north_west.include?(state)
          return 100000002
        elsif south_south.include?(state)
          return 100000005
        elsif south_west.include?(state)
          return 100000004
        elsif south_east.include?(state)
          return 100000003
        end

end


  # POST /users
  # POST /users.json
def create
    user = Member.new(user_params)
      if user.save
        code = user.id + 24523009
        user.update(affiliate_code: code)
          namel =user.name.split(' ')
        fname = namel[0]
        lname = namel[1]

          sexint = getGender(user)
          geoint = geo_zone(user.state)
          typeint = 100000001
      

        client = DynamicsCRM::Client.new({organization_name: ENV['ORG_NAME']})
        client.authenticate(ENV['USER'], ENV['PASSWORD'])
   
      res = client.create('contact', firstname: fname, lastname: lname, emailaddress1: user.email, 
          gendercode: {type: "OptionSetValue", value: sexint}, mobilephone: user.phone, 
          address1_stateorprovince: user.state, new_geopoliticalzone: {type: "OptionSetValue", value: geoint}, new_supportertype: {type: "OptionSetValue", value: typeint})
        crmid = res.id
        user.update(crm_id: crmid)
        sign_in(user)
        render json: user,serializer: Api::V1::MembersSerializer, :status => 201
       else
         render json: "errors", :status => 422
       end  
 end
  # PATCH/PUT /users/1
  # PATCH/PUT /users/1.json


  # DELETE /users/1
  # DELETE /users/1.json
  def destroy
    current_user.destroy
    head 204
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user
      user = Member.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def user_params
      params.require(:member).permit!
    end
end
