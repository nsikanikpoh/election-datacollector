class ProspectsController < ApplicationController
 before_action :set_user, only: [:opportunity, :qualified, :show, :edit, :update, :destroy]
  skip_before_action :authenticate_user!, only: [:new, :create, :show]
  # GET /users
  # GET /users.json
  def index
    @users = Prospect.all.paginate(page: params[:page], per_page: 5).order(created_at: :desc, id: :desc)
  end

  def my_prospects
  	if current_user.fund_raiser?
    	@users = current_user.prospects
    else redirect_to root_path, notice: '0hops! you are not a fund raiser'
  end
end

  # GET /users/1
  # GET /users/1.json
  def show
    @conversations ||= []

    conversations = Conversation.all
    if conversations.any?
        conversations.each do |c|
          if c.pros_id == @user.id
            @conversations << c
          end
        end
    end
  end
  
  # GET /users/new
  def new
    @user = Prospect.new()
  end

  # GET /users/1/edit
  def edit
  end

def getGender(user)
    if user.gender == "Female"
          return 2
        elsif user.gender == "Male"
          return 1
        end
end

 # POST /users
  # POST /users.json

  def create
    if current_user

      @patriot = current_user
      @user = @patriot.prospects.create(user_params)
      @user.password = @user.phone
      @user.password_confirmation = @user.phone
      @user.opportunity = 0
      @user.fundraiser_email = @patriot.email
      @user.created_at = Time.now
      @user.save
    respond_to do |format|
      if @user.save
        code = @user.id + 24523009
        @user.update(affiliate_code: code)
         namel =@user.name.split(' ')
        fname = namel[0]
        lname = namel[1]
          sexint = getGender(@user)
          typeint = 100000000
        

        client = DynamicsCRM::Client.new({organization_name: ENV['ORG_NAME']})
        client.authenticate(ENV['USER'], ENV['PASSWORD'])
   
        res = client.create('contact', firstname: fname, lastname: lname, emailaddress1: @user.email, 
          gendercode: {type: "OptionSetValue", value: sexint}, mobilephone: @user.phone, 
          address1_stateorprovince: @user.state, new_supportertype: {type: "OptionSetValue", value: typeint})
      
        crmid = res.id
        @user.update(crm_id: crmid)

        format.html { redirect_to root_path, notice: 'Prospect Account was successfully created. Thank you!' }
        format.json { render :show, status: :created, location: @user }
      else
        format.html { render :new }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end



    else

      referrer_code = cookies[:referrer_code]

      if referrer_code.present?
        if User.find_by_affiliate_code(referrer_code)
           @patriot = User.find_by_affiliate_code(referrer_code)
           @user = @patriot.prospects.create(user_params)
           @user.opportunity = 0
           @user.fundraiser_email = @patriot.email
           @user.created_at = Time.now
           @user.save

      respond_to do |format|
      if @user.save
        code = @user.id + 24523009
        @user.update(affiliate_code: code)
        namel =@user.name.split(' ')
        fname = namel[0]
        lname = namel[1]
          sexint = getGender(@user)
          typeint = 100000000
        

        client = DynamicsCRM::Client.new({organization_name: ENV['ORG_NAME']})
        client.authenticate(ENV['USER'], ENV['PASSWORD'])
   
        res = client.create('contact', firstname: fname, lastname: lname, emailaddress1: @user.email, 
          gendercode: {type: "OptionSetValue", value: sexint}, mobilephone: @user.phone, 
          address1_stateorprovince: @user.state, new_supportertype: {type: "OptionSetValue", value: typeint})
      
        crmid = res.id
        @user.update(crm_id: crmid)
        format.html { redirect_to root_path, notice: 'Your Account was successfully created. Thank you!' }
        format.json { render :show, status: :created, location: @user }
      else
        format.html { render :new }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
        else
          redirect_to new_member_path, notice: 'Please Sign Up, The Referral Link you clicked has Expired'
     
        end
      else
          redirect_to new_member_path, notice: 'Please Sign Up, The Referral Link you clicked has Expired'
     
      end
  end
end


 def opportunity
        @user.update(opportunity: 1)
       redirect_to @user, notice: 'Prospect was successfully added in opportunities'
 
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
        
    end

     def donated
      @users ||= []
      users = User.all
      dons = Donation.all
      users.each do |p|
            if p.fundraiser_email == current_user.email
               
                 if p.type == "Member" || p.type == "User" || p.type == "Patriot" || p.type == "Champion" || p.type == "Ambassador"
                     @users << p
                  end
            end
          end
       
     end

def amount_raised
      @donors ||= []
      users = User.all
      dons = Donation.all
      users.each do |p|
            if p.fundraiser_email == current_user.email
               
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
      params.require(:prospect).permit(:fund_raiser_id, :referrer_code, :affiliate_code, :name, :birthday, :image, :remove_image, :image_cache, :title, :gender, :phone, :type, :address, :location, :state, :email, :password, :remember_me)
    end
end
