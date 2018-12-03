class  Api::V1::DashboardController < Api::V1::BaseController
  def dashboard
    # @donation = Donation.new()
     @donations ||=[]
   # storage for referrals and affilations through eight generations
   @dons = Donation.where(type: [nil, ""])
   if @dons
      @dons.each do |u| 
           if u.donator_id == @current_user.id
      
              @donations << u
    
           end
      end
   end
    #generate first generation referrals

    @firstgeners = referral_gen(@current_user)

    
    @secondgeners ||= []
    
   
    @thirdgeners ||= []
    
   
    @fourthgeners ||= []
    
    
   
    @fifthgeners ||= []
   
    
    @sixthgeners ||= []
    
   
    @seventhgeners ||= []
   
   
    @eightgeners ||= []
  

  
    @users = User.all
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

  
  render json: {
    firstgeners: @firstgeners, each_serializer: Api::V1::UserSerializer, 
    secondgeners: @secondgeners, each_serializer: Api::V1::UserSerializer,
    thirdgeners: @thirdgeners, each_serializer: Api::V1::UserSerializer,
    fourthgeners: @fourthgeners, each_serializer: Api::V1::UserSerializer,
    fifthgeners: @fifthgeners, each_serializer: Api::V1::UserSerializer,
    sixthgeners: @sixthgeners, each_serializer: Api::V1::UserSerializer,
    seventhgeners: @seventhgeners, each_serializer: Api::V1::UserSerializer,
    eightgeners: @eightgeners, each_serializer: Api::V1::UserSerializer,
   }
#@eightgeners = @eightgeners1.flatten
  end

#generate all affiliations  of current_user



  def referral_gen(user)
     referrals = user.referrals.to_a
     return referrals
  end
  

  def downlines
    dashboard
  end

  def accountupdate
  	@user = current_user
  	@user.update(user_params)
  	respond_to do |format|
      if @user.update(user_params)
        namel =@user.name.split(' ')
        fname = namel[0]
        lname = namel[1]

        if @user.gender == "Female"
          sexint = 2
        elsif @user.gender == "Male"
          sexint = 1
        end

        if @user.type == "Member"
          typeint = 1
        elsif @user.type == "FundRaiser"
          typeint = 4
        end

        client = DynamicsCRM::Client.new({organization_name: "next2you0"})
        client.authenticate('cibezim@next2you.com.ng', 'Victor116')
   
        client.create('contact', firstname: fname, lastname: lname, emailadress1: @user.email, 
          gendercode: {type: "OptionSetValue", value: sexint}, mobilephone: @user.phone, 
          address1_stateorprovince: @user.state, new_supportertype: {type: "OptionSetValue", value: typeint})
       
       
        format.html { redirect_to root_path, notice: 'Account was successfully updated.' }
        format.json { render :show, status: :ok, location: @user }
      	format.js	
      else
        format.html { redirect_to root_path }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      	format.js
      end
    end

  end


  private
    
    # Never trust parameters from the scary internet, only allow the white list through.
    def user_params
      params.require(:user).permit(:name, :email, :gender, :phone, :location, :state)
    end

end
