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
          return 100000001
        elsif user.gender == "Male"
          return 100000000
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

        namel =@user.name.split(' ')
        fname = namel[0]
        lname = namel[1]
          sexint = getGender(@user)
          typeint = 100000004
        

        client = DynamicsCRM::Client.new({organization_name: ENV['ORG_NAME']})
        client.authenticate(ENV['USER'], ENV['PASSWORD'])
   
        res = client.create('contact', firstname: fname, lastname: lname, emailaddress1: @user.email, 
          gendercode: {type: "OptionSetValue", value: sexint}, mobilephone: @user.phone, 
          address1_stateorprovince: @user.state, new_supportertype: {type: "OptionSetValue", value: typeint})
      crmid = res.id
        @user.update(crm_id: crmid)
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
  def update
    respond_to do |format|
      if @user.update(user_params)
        format.html { redirect_to @user, notice: 'User was successfully updated.' }
        format.json { render :show, status: :ok, location: @user }
      else
        format.html { render :edit }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /users/1
  # DELETE /users/1.json
  def destroy
    @user.destroy
    respond_to do |format|
      format.html { redirect_to users_url, notice: 'User was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

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
