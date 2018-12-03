class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update, :destroy]
  skip_before_action :authenticate_user!, only: [:new, :create, :show]
  # GET /users
  # GET /users.json
  def index
    @users = User.all
  end

 def amount_raised
      @donors ||= []
      userss ||= []
          users = User.all
            users.each do |p|
            if p.fundraiser_email == @user.email
                userss << p
            end
          end
      @amountd = 0
       donations ||= []
       dons = Donation.all
          
          userss.each do |p|
             if p
                  for i in dons do
                      if i
                        if i.donator
                          if i.donator.email == p.fundraiser_email
                              donations << i
                              @donors << p
                          end
                        end
                    end
                  end
                end
            end
           
        donations.each do |d|
            @amountd += d.amount 
        end
      end


  def opportunities
       @userso ||= []
        prospects = Prospect.all
        if prospects
        prospects.each do |p|
            if p.opportunity == "Found"
                 if p.fundraiser_email == @user.email
                    @userso << p
                  end
            end
        end
      end
    end

    def donated
      amount_raised
    end

  def fundraiser_workflows
      amount_raised
      opportunities
      donated

       if @user.fund_raiser?
      if @user.prospects.any?

        d = @user.prospects.last.created_at.to_s.split(' ')
        contacts = @user.prospects.count
        @last_contact = @user.prospects.last.name
        @date_added = d[0]
        @time_added = d[1]
        @last_contact_op = @user.prospects.last.opportunity
        @total_op = @userso.count
        @total_donated = @donors.count
        @total_contacts = @total_donated + contacts
        @total_amount = @amountd
      else
        @last_contact = "Nil"
        @date_added = "Nil"
        @time_added = "Nil"
        @last_contact_op = "Nil"
        @total_op = "Nil"
        @total_donated = @donors.count
        @total_contacts = 0
        @total_amount = @amountd
     end
   end

  end
  # GET /users/1
  # GET /users/1.json
  def show
    fundraiser_workflows
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
  



  def api_token
    @user = User.find(params[:id])
     respond_to do |format|
      format.json{render :json => @users.to_json, :status => :ok }
    end
  end

  # GET /users/new
  def new
    @user = User.new

     affiliate = User.find_by_affiliate_code(params[:referrer_code])
    cookies[:referrer_code] = { :value => params[:referrer_code] } if affiliate
    
  end

  # GET /users/1/edit
  def edit
  end

  # POST /users
  # POST /users.json
  def create
    @user = User.new(user_params)

    respond_to do |format|
      if @user.save
        format.html { redirect_to @user, notice: 'User was successfully created.' }
        format.json { render :show, status: :created, location: @user }
      else
        format.html { render :new }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
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
      params.require(:user).permit(:referrer_code, :affiliate_code, :name, :birthday, :image, :remove_image, :image_cache, :title, :gender, :phone, :type, :address, :location, :state, :password, :remember_me)
    end
end



