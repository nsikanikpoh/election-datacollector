class Api::V1::SponsorshipsController < Api::V1::BaseController
  		 before_action :set_donation, only: [:show, :edit, :update, :destroy]
  skip_before_action :authenticate_user!, only: [:makepayment]
  # GET /donations
  # GET /donations.json

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

    render json: @donations, each_serializer: Api::V1::SponsorshipsSerializer
  end

  # GET /donations/1
  # GET /donations/1.json
  def show
    @donator = User.find(@donation.donator_id)
    @interest = InterestLine.find(@donation.interest_line_id)
     render json: {
    sponsorship: @donation, each_serializer: Api::V1::SponsorshipsSerializer, 
    sponsor: @donator, each_serializer: Api::V1::UserSerializer,
    interest_line: @interest, each_serializer: Api::V1::InterestLineSerializer,
   }
  end

  # GET /donations/new

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
        CrmsponsorJob.set(wait: 20.seconds).perform_later(donation)
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
    cookies[:interest_line_id] = params[:donation][:interest_line_id]
    transaction_reference = params[:donation][:reference]
    paystackObj = Paystack.new(ENV['PUBLIC_KEY_TEST'], ENV['SECRET_KEY_TEST'])
    transactions = PaystackTransactions.new(paystackObj)
    result = transactions.verify(transaction_reference)
    if result['data']['status'] == "success"
        @res = result['data']
        line = InterestLine.find(cookies[:interest_line_id].to_i)
          @donation = line.sponsorships.create(amount: (@res['amount'].to_f)/100,
          channel: @res['channel'], 
          reference: @res['reference'], 
          gateway_response: @res['gateway_response'],
          currency: @res['currency'],
          donator_id: @current_user.id,
          donator_type: @current_user.type,
          status: @res['status'],
          created_at: Time.now,
          updated_at: Time.now)
        @donation.save 
  
      if @donation.save
     # insert_to_crm(@donation)
     CrmsponsorJob.set(wait: 20.seconds).perform_later(@donation, @current_user)
       
      render json: @donation, each_serializer: Api::V1::SponsorshipsSerializer

      else    
        render :json => @donation.errors, status: :unprocessable_entity
      end
  else    
        render :json => errors, status: :unprocessable_entity
  end     
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
