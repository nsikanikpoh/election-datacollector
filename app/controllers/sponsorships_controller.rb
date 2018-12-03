class SponsorshipsController < ApplicationController
  before_action :set_donation, only: [:show, :edit, :update, :destroy]
  skip_before_action :authenticate_user!, only: [:makepayment]
  # GET /donations
  # GET /donations.json
  def index
    @donations = Sponsorship.all.paginate(page: params[:page], per_page: 5).order(created_at: :desc, id: :desc)
  end

  def sponsorship_history
     @donations ||=[]
   # storage for referrals and affilations through eight generations
   @dons = Sponsorship.all
   if @dons
      @dons.each do |u| 
    if u.donator_id == current_user.id
      
       @donations << u
    
    end
   end
  end
  end

  # GET /donations/1
  # GET /donations/1.json
  def show
    @donator = User.find(@donation.donator_id)
  end

  # GET /donations/new
  def new
    @donation = Sponsorship.new()
    @lines = InterestLine.all
  end

def sea
   @donation.amount = donation_params[:amount]
    @donation.line = donation_params[:line].to_i

    if @donation.line == "monthly"
      @donation.expires_on = Date.today + 30.days
    elsif @donation.line == "quarterly"

      @donation.expires_on = Date.today + 90.days

    elsif @donation.line == "yearly"
      @donation.expires_on = Date.today + 365.days
    end

    @donation.donator_id = current_user.id
    @donation.donator_type = current_user.type
    @donation.save
    respond_to do |format|
      if @donation.save
        client = DynamicsCRM::Client.new({organization_name: ENV['ORG_NAME']})
        client.authenticate(ENV['USER'], ENV['PASSWORD'])
        #amount = BigDecimal.new(@donation.amount.to_i)

          dtype = getType(@donation)
          crmid = client.create('new_donation', new_donationmade: @donation.amount.to_i,
          new_donatoremail: @donation.donator.email,
          new_donationtype: {type: "OptionSetValue", value: dtype})

          contacts = [ DynamicsCRM::XML::EntityReference.new("new_donation", crmid.id)]
          client.associate("contact", @donation.donator.crm_id, "new_contact_new_donation_donator", contacts)

        format.html { redirect_to @donation, notice: 'Donation was successfully made.' }
        format.json { render :show, status: :created, location: @donation }
      else
        format.html { render :new }
        format.json { render json: @donation.errors, status: :unprocessable_entity }
      end
    end
end


def getType(user)
      if user.line == "monthly"
          return 100000000
      elsif user.line == "quarterly"
          return 100000001

      elsif user.line == "yearly"
          return 100000002
      end

end



  # POST /donations
  # POST /donations.json
  def create
   
    cookies[:interest_line] = donation_params[:interest_line_id].to_i
    ref = SecureRandom.hex
    cookies[:ref] = ref
    namel =current_user.name.split(' ')
    fname = namel[0]
    lname = namel[1]
    paystackObj = Paystack.new(ENV['PUBLIC_KEY_TEST'], ENV['SECRET_KEY_TEST'])
    transactions = PaystackTransactions.new(paystackObj)
    result = transactions.initializeTransaction(
    :reference => ref,
    :amount => donation_params[:amount].to_i*100,
    :email => current_user.email,
    :firstname => fname,
    :lastname => lname
    )
    auth_url = result['data']['authorization_url']

    redirect_to auth_url
    
  end

  # PATCH/PUT /donations/1
  # PATCH/PUT /donations/1.json


  # DELETE /donations/1
  # DELETE /donations/1.json
  def destroy
    @donation.destroy
    respond_to do |format|
      format.html { redirect_to donations_url, notice: 'Donation was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_donation
      @donation = Sponsorship.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def donation_params
      params.require(:sponsorship).permit!
    end
end
