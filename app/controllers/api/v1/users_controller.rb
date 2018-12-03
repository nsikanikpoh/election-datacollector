class Api::V1::UsersController < Api::V1::BaseController
 skip_before_action :authenticate_user!, only: [:create]
  skip_before_action :verify_authenticity_token
  before_action :set_user, only: [:show, :edit, :update, :destroy]
   #before_action :authenticate_with_token!, only: [:update, :destroy]
   
  # GET /users
  # GET /users.json
  
   def index
    users = User.all

    render jsonapi: users, each_serializer: Api::V1::UsersSerializer
  end

  # GET /users/1
  # GET /users/1.json
   def show
    render json: user, serializer: Api::V1::UserSerializer
  end


  def profile
     user = User.find(params[:id])
    
     #@donation = Donation.new()
     #@donations ||=[]
   # storage for referrals and affilations through eight generations
  # @dons = Donation.all
   #if @dons
  #    @dons.each do |u| 
   #        if u.donator_id == user.id
      
    #          @donations << u
    
     #      end
    #  end
   #end
    #generate first generation referrals

    @firstgeners = referral_gen(user)

    
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
    user: user, each_serializer: Api::V1::UserSerializer,
    firstgeners: @firstgeners, each_serializer: Api::V1::UserSerializer, 
    secondgeners: @secondgeners, each_serializer: Api::V1::UserSerializer,
    thirdgeners: @thirdgeners, each_serializer: Api::V1::UserSerializer,
    fourthgeners: @fourthgeners, each_serializer: Api::V1::UserSerializer,
    fifthgeners: @fifthgeners, each_serializer: Api::V1::UserSerializer,
    sixthgeners: @sixthgeners, each_serializer: Api::V1::UserSerializer,
    seventhgeners: @seventhgeners, each_serializer: Api::V1::UserSerializer,
    eightgeners: @eightgeners, each_serializer: Api::V1::UserSerializer   }
#@eightgeners = @eightgeners1.flatten
  end

#generate all affiliations  of current_user



  def referral_gen(user)
     referrals = user.referrals.to_a
     return referrals
  end
  






  # POST /users
  # POST /users.json
def create
    user = Member.new(user_params)
      if user.save
        code = user.id + 24523009
        user.update(affiliate_code: code)
        render :json => user.to_json, :status => 201
       else
         render json: "errors", :status => 422
       end  
 end
  # PATCH/PUT /users/1
  # PATCH/PUT /users/1.json
  def update
    
    respond_to do |format|
      if user.update(user_params)
        format.json{render :json => user.to_json, :status => :ok, location: [:api, user]}
       else
         format.json { render :json => user.errors, status: :unprocessable_entity }
       end
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
      params.require(:user).permit!
    end
end