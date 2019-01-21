class Api::V1::ProspectsController < Api::V1::BaseController
 before_action :set_user, only: [:opportunity, :qualified, :show, :edit, :update, :destroy]
 skip_before_action :verify_authenticity_token
  # GET /users
  # GET /users.json
  def index
    @users = Prospect.all
  end

  def my_prospects
    	@users = @current_user.prospects
      render json: @users, each_serializer: Api::V1::ProspectsSerializer
  end

  # GET /users/1
  # GET /users/1.json
  def show
    render json: @user, each_serializer: Api::V1::ProspectsSerializer
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
	   @patriot = @current_user
      @user = @patriot.prospects.create(user_params)
      @user.password = @user.phone
      @user.password_confirmation = @user.phone
      @user.opportunity = 0
      @user.fundraiser_email = @patriot.email
      @user.created_at = Time.now
      @user.save
      if @user.save
        code = @user.id + 24523009
        @user.update(affiliate_code: code)

        ProspectupJob.set(wait: 20.seconds).perform_later(@user)
      render json: @user, each_serializer: Api::V1::ProspectsSerializer
     else
        render json: "errors", status: :unprocessable_entity 
        
     end
  end

    def opportunity
        @user.update(opportunity: 1)
        render json: @user, each_serializer: Api::V1::ProspectsSerializer
    end

    def opportunities
       @users ||= []
        prospects = Prospect.all
        if prospects
        prospects.each do |p|
            if p.opportunity == "Found"
                 if p.fundraiser_email == @current_user.email
                    @users << p
                  end
            end

        end
      end
        render json: @users, each_serializer: Api::V1::ProspectsSerializer
    end


      def donated
          @users ||= []
      users = User.all
      dons = Donation.where(type: [nil, ""])
      users.each do |p|
            if p.fundraiser_email == @current_user.email
               
                 if p.type == "Member" || p.type == "User" || p.type == "Patriot" || p.type == "Champion" || p.type == "Ambassador"
                     @users << p
                  end
            end
          end
        render json: @users, each_serializer: Api::V1::MembersSerializer
    end

def amount_raised
      donations ||= []
      @donors ||= []
      users = User.all
      dons = Donation.where(type: [nil, ""])
      users.each do |p|
            if p.fundraiser_email == @current_user.email
               
                 if p.type == "Member" || p.type == "User" || p.type == "Patriot" || p.type == "Champion" || p.type == "Ambassador"
                     @donors << p
                  end
            end
          end
       
      
           
      dons.each do |d|
          
          @donors.each do |e|
            if d.donator_id == e.id
               @amountd += d.amount
            end
        end
      end
        render json: @amountd, each_serializer: Api::V1::DonationSerializer
    
      end


    def prospect_conversations
        @prospect = Prospect.find(params[:id])
        @conversations = @prospect.conversations
        render json: @conversations, each_serializer: Api::V1::ConversationsSerializer
    end

    

  # PATCH/PUT /users/1
  # PATCH/PUT /users/1.json

  # DELETE /users/1
  # DELETE /users/1.json


  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user
      @user = Prospect.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def user_params
      params.require(:prospect).permit!
    end
end
