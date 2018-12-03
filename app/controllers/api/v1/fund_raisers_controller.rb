class Api::V1::FundRaisersController < Api::V1::BaseController
  before_action :set_user, only: [:show, :edit, :update, :destroy]
  skip_before_action :authenticate_user!, only: [:new, :create, :show]
  # GET /users
  # GET /users.json
  def index
    @users = FundRaiser.all
  end

  # GET /users/1
  # GET /users/1.json
  def show
     @firstgeners = referral_gen(@user)

    
    @secondgeners ||= []
    
   
    @thirdgeners ||= []
    
   
    @fourthgeners ||= []
    
    
   
    @fifthgeners ||= []
   
    
    @sixthgeners ||= []
    
   
    @seventhgeners ||= []
   
   
    @eightgeners ||= []
  

  
    @users = User.all
    if @user.referrer_code
      @users.each do |e|
        if e.affiliate_code == @user.referrer_code
          @referrer = e
        end
      end 
    end
 #loop first generation referrals to get the affiliates to form our second generation affiliations 
 #@firstgeners = @firstgeners1.flatten

 #@secondgeners1 = []
 #@firstgeners = flatten_scopes(@firstgeners)
     if @firstgeners.any?
      @firstgeners.each do |u|
      @users.each do |e|
        if e.referrer_code == u.affiliate_code
          @secondgeners.push(e)
        end
      end
    end
end
  #@secondgeners = @secondgeners1.flatten
   #from second generation referrals generate the affiliations 
  # @thirdgeners1 = []
  #@secondgeners = flatten_scopes(@secondgeners)
  if @secondgeners.any?
      @secondgeners.each do |u|
        @users.each do |e|
        if e.referrer_code == u.affiliate_code
          @thirdgeners.push(e)
        end
      end
   end
   
  end


 #@thirdgeners = @thirdgeners1.flatten

#@thirdgeners = flatten_scopes(@thirdgeners)
     #from third generation referrals generate the affiliations
   if @thirdgeners.any?
   @thirdgeners.each do |u| 
       @users.each do |e|
        if e.referrer_code == u.affiliate_code
          @fourthgeners.push(e)
        end
      end
   end
  end 
  #@fourthgeners = @fourthgeners1.flatten


     #from third generation rSeferrals generate the affiliations
  #@fourthgeners = flatten_scopes(@fourthgeners)
   if @fourthgeners.any?
   @fourthgeners.each do |u| 
       @users.each do |e|
        if e.referrer_code == u.affiliate_code
          @fifthgeners.push(e)
        end
      end
      end
  end

 
 # @fifthgeners = @fifthgeners1.flatten

#@fifthgeners = flatten_scopes(@fifthgeners)
   if @fifthgeners.any?
   @fifthgeners.each do |u| 
    @users.each do |e|
        if e.referrer_code == u.affiliate_code
           @sixthgeners.push(e)
        end
      end
   end
  end


#  @sixthgeners = @sixthgeners1.flatten 
#@sixthgeners = flatten_scopes(@sixthgeners)
   if @sixthgeners.any?
   @sixthgeners.each do |u|
      @users.each do |e|
        if e.referrer_code == u.affiliate_code
          @seventhgeners.push(e)
        end
      end 
   end
  end


#@seventhgeners = @seventhgeners.flatten

#@secondgeners = flatten_scopes(@seventhgeners)
   if @seventhgeners.any?
   @seventhgeners.each do |u| 
      @users.each do |e|
        if e.referrer_code == u.affiliate_code
          @eightgeners.push(e)
        end
      end
   end
  end 

  
#@eightgeners = @eightgeners1.flatten
 
 end
#generate all affiliations  of current_user



  def referral_gen(user)
     referrals = user.referrals.to_a
     return referrals
  end
  

 

  # GET /users/new
  def new
     
    @user = FundRaiser.new()
  end

  # GET /users/1/edit
  def edit
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
    user = FundRaiser.new(user_params)
      if user.save
        code = user.id + 24523009
        user.update(affiliate_code: code)

        namel =user.name.split(' ')
        fname = namel[0]
        lname = namel[1]

          sexint = getGender(user)
          typeint = 100000003
        

        client = DynamicsCRM::Client.new({organization_name: ENV['ORG_NAME']})
        client.authenticate(ENV['USER'], ENV['PASSWORD'])
   
        res = client.create('contact', firstname: fname, lastname: lname, emailaddress1: user.email, 
          gendercode: {type: "OptionSetValue", value: sexint}, mobilephone: user.phone, 
          address1_stateorprovince: user.state, new_supportertype: {type: "OptionSetValue", value: typeint})
      
      crmid = res.id
        user.update(crm_id: crmid)

        sign_in(user)
      render json: user,serializer: Api::V1::FundRaisersSerializer, :status => 201
       else
         render json: "errors", :status => 422
         end
   
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
      @user = User.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def user_params
      params.require(:fund_raiser).permit(:referrer_code, :affiliate_code, :name, :birthday, :image, :remove_image, :image_cache, :title, :gender, :phone, :type, :address, :location, :state, :email, :password, :remember_me)
    end
end
