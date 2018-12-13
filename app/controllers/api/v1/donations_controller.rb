require "date"
class Api::V1::DonationsController < Api::V1::BaseController
  before_action :set_donation, only: [:show, :edit, :update, :destroy]
skip_before_action :verify_authenticity_token
  # GET /donations
  # GET /donations.json

  def donation_history
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
 
  render json: @donations, each_serializer: Api::V1::DonationsSerializer

  end
  # GET /donations/1
  # GET /donations/1.json
  def show
    @donator = User.find(@donation.donator_id)
      render json: {
    donation: @donation, each_serializer: Api::V1::DonationsSerializer, 
    donator: @donator, each_serializer: Api::V1::UserSerializer,
   }
  end

  # GET /donations/new
 
  def upgrade
    @donation = Donation.new()
  end
  # GET /donations/1/edit
  def edit
  end

    def insert_to_crm(donation)

        client = DynamicsCRM::Client.new({organization_name: ENV['ORG_NAME']})
        client.authenticate(ENV['USER'], ENV['PASSWORD'])
   
        #amount = BigDecimal.new(@donation.amount.to_i)

          dtype = getType(donation)
          crmid = client.create('new_donation', new_amountdonated: donation.amount.to_i,
          new_donationtype: {type: "OptionSetValue", value: dtype})

          contacts = [ DynamicsCRM::XML::EntityReference.new("new_donation", crmid.id)]
          client.associate("contact", donation.donator.crm_id, "new_contact_new_donation_Donator", contacts)

end

def fundraiser_donate
    cookies[:donator_id] = params[:donation][:donator_id]
     cookies[:line] = params[:donation][:line]
    transaction_reference = params[:donation][:reference]
    paystackObj = Paystack.new(ENV['PUBLIC_KEY_TEST'], ENV['SECRET_KEY_TEST'])
    transactions = PaystackTransactions.new(paystackObj)
    result = transactions.verify(transaction_reference)
    if result['data']['status'] == "success"
        @res = result['data']

      user = User.find(cookies[:donator_id].to_i)

      if cookies[:line].to_i == 0
          expires_on = Date.today + 30.days
      elsif cookies[:line].to_i == 1

          expires_on = Date.today + 90.days

      elsif cookies[:line].to_i == 2
          expires_on = Date.today + 365.days
      end

    
          if (@res['amount'].to_f)/100 > 24000
               user.update(type: "Patriot")
          else
              user.update(type: "Member")
          end
          @donation = Donation.create(amount: (@res['amount'].to_f)/100,
          line: cookies[:line].to_i,
          channel: @res['channel'], 
          reference: @res['reference'], 
          gateway_response: @res['gateway_response'],
          currency: @res['currency'],
          donator_id: user.id,
          donator_type: user.type,
          status: @res['status'], 
          expires_on: expires_on,
          created_at: Time.now,
          updated_at: Time.now)
       @donation.save 
      if @donation.save

        insert_to_crm(@donation)
        @donator = User.find(@donation.donator_id)
      render json: {
    donation: @donation, each_serializer: Api::V1::DonationsSerializer, 
    donator: @donator, each_serializer: Api::V1::UserSerializer,
   }
      else    
        format.json { render :json => @donation.errors, status: :unprocessable_entity}
      end
    end
end

def getGender(user)
    if user.interest_line.id == 2
          return 100000002
        elsif user.interest_line.id == 3
          return 100000003

        elsif user.interest_line.id == 4
          return 100000004

        elsif user.interest_line.id == 5
          return 100000005

        elsif user.interest_line.id == 6
          return 100000000
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


  def formatdate(d)
    sd= ""
    dat = d.to_s.split(//)
    dat.each do |s|
      sd << s
    end

    year = sd[0..3]
    month = sd[5..6]
    day = sd[8..9]
    return month+'/'+day+'/'+year

   end

  # POST /donations
  # POST /donations.json
  def create
    cookies[:line] = params[:donation][:line]
    transaction_reference = params[:donation][:reference]
    paystackObj = Paystack.new(ENV['PUBLIC_KEY_TEST'], ENV['SECRET_KEY_TEST'])
    transactions = PaystackTransactions.new(paystackObj)
    result = transactions.verify(transaction_reference)
    if result['data']['status'] == "success"
        @res = result['data']

      if cookies[:line].to_i == 0
          expires_on = Date.today + 30.days
      elsif cookies[:line].to_i == 1

          expires_on = Date.today + 90.days

      elsif cookies[:line].to_i == 2
          expires_on = Date.today + 365.days
      end

          @donation = Donation.create(amount: (@res['amount'].to_f)/100,
          line: cookies[:line].to_i,
          channel: @res['channel'], 
          reference: @res['reference'], 
          gateway_response: @res['gateway_response'],
          currency: @res['currency'],
          donator_id: @current_user.id,
          donator_type: @current_user.type,
          status: @res['status'], 
          expires_on: expires_on,
          created_at: Time.now,
          updated_at: Time.now)
    @donation.save 
    if @donation.save
      insert_to_crm(@donation)
        @donator = User.find(@donation.donator_id)
      render json: {
   donation: @donation, each_serializer: Api::V1::DonationsSerializer, 
    donator: @donator, each_serializer: Api::V1::UserSerializer,
   } 
      else    
        format.json { render :json => @donation.errors, status: :unprocessable_entity}
  end
end
end



  # PATCH/PUT /donations/1
  # PATCH/PUT /donations/1.json
  def update
    respond_to do |format|
      if @donation.update(donation_params)
        format.html { redirect_to @donation, notice: 'Donation was successfully updated.' }
        format.json { render :show, status: :ok, location: @donation }
      else
        format.html { render :edit }
        format.json { render json: @donation.errors, status: :unprocessable_entity }
      end
    end
  end

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
      @donation = Donation.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def donation_params
      params.require(:donation).permit!
    end
end
