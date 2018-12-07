class FundRaisersController < ApplicationController
  before_action :set_user, only: [:opportunities, :amount_raised, :fundraiser_workflows, :show, :edit, :update, :destroy]
layout 'application', only: [:show, :index]
  skip_before_action :authenticate_user!, only: [:new, :create, :show]
  # GET /users
  # GET /users.json
  def index
    @users = FundRaiser.all.paginate(page: params[:page], per_page: 5).order(created_at: :desc, id: :desc)
  end

 def amount_raised
    @amountd = 0
    donations ||= []
      @donors ||= []
      users = User.all
      dons = Donation.all
      users.each do |p|
            if p.fundraiser_email == @user.email
               
                 if p.type == "Member" || p.type == "User" || p.type == "Patriot" || p.type == "Champion" || p.type == "Ambassador"
                     @donors << p
                  end
            end
          end
       
      
           
        dons.each do |d|
          if d
          @donors.each do |e|
            if d.donator_id == e.id
               @amountd += d.amount
            end
          end
        end
      end
  end
def donated
  amount_raised
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

   

  def fundraiser_workflows
      amount_raised
      opportunities
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
  end
  

 

  # GET /users/new
  def new
    @user = FundRaiser.new()
  end

  # GET /users/1/edit
  def edit
  end

#create affiliations
def create_affiliation(affiliate, referrer)
    Affiliation.create(:affiliate => affiliate, :referred => referrer)
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
    referrer_code = cookies[:referrer_code]
  

if referrer_code.present?
  if User.find_by_affiliate_code(referrer_code)
    @affiliate = User.find_by_affiliate_code(referrer_code)
     @user = FundRaiser.new(user_params)
     @user.referrer_code = referrer_code
    # subscription = PaymentSystem.get_subscription(referrer.subscription_id)
     #if subscription.trial_end > Time.now.to_i
     #  subscription.trial_end = (Time.at(subscription.trial_end) + 90.days).to_i
     #else
     #  subscription.trial_end = (Time.now + 90.days).to_i
     #end
    # subscription.save
    # @user.referred_by = referred_by.to_i
    @user.save
     respond_to do |format|
      if @user.save
        code = @user.id + 24523009
        @user.update(affiliate_code: code)
        create_affiliation(@affiliate, @user)

         namel =@user.name.split(' ')
        fname = namel[0]
        lname = namel[1]

          sexint = getGender(user)
          typeint = 100000004
        

        client = DynamicsCRM::Client.new({organization_name: ENV['ORG_NAME']})
        client.authenticate(ENV['USER'], ENV['PASSWORD'])
   
        res = client.create('contact', firstname: fname, lastname: lname, emailaddress1: user.email, 
          gendercode: {type: "OptionSetValue", value: sexint}, mobilephone: user.phone, 
          address1_stateorprovince: user.state, new_supportertype: {type: "OptionSetValue", value: typeint})
      
        crmid = res.id
        @user.update(crm_id: crmid)

        sign_in(@user)
        format.html { redirect_to root_path, notice: 'Fund Raiser Account was successfully created. Thank you!' }
        format.json { render :show, status: :created, location: @user }
      else
        format.html { render :new }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
   end



else    

    @user = FundRaiser.new(user_params)
    respond_to do |format|
      if @user.save
        code = @user.id + 24523009
        @user.update(affiliate_code: code)
         create_affiliation(@affiliate, @user)

         namel =@user.name.split(' ')
        fname = namel[0]
        lname = namel[1]

          sexint = getGender(user)
          typeint = 100000004
        

        client = DynamicsCRM::Client.new({organization_name: ENV['ORG_NAME']})
        client.authenticate(ENV['USER'], ENV['PASSWORD'])
   
        res = client.create('contact', firstname: fname, lastname: lname, emailaddress1: user.email, 
          gendercode: {type: "OptionSetValue", value: sexint}, mobilephone: user.phone, 
          address1_stateorprovince: user.state, new_supportertype: {type: "OptionSetValue", value: typeint})
      
        crmid = res.id
        @user.update(crm_id: crmid)
        
        sign_in(@user)
        format.html { redirect_to root_path, notice: 'Fund Raiser Account was successfully created. Thank you!' }
        format.json { render :show, status: :created, location: @user }
      else
        format.html { render :new }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
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
      params.require(:fund_raiser).permit(:referrer_code, :affiliate_code, :name, :birthday, :image, :remove_image, :image_cache, :title, :gender, :phone, :type, :address, :location, :state, :email, :password, :remember_me)
    end
end
