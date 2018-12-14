class Api::V1::QuickDonationsController < Api::V1::BaseController
  before_action :set_quick_donation, only: [:show, :edit, :update, :destroy]
    skip_before_action :authenticate_user!, only: [:create, :show]
  skip_before_action :verify_authenticity_token
  # GET /quick_donations
  # GET /quick_donations.json


  # GET /quick_donations/1
  # GET /quick_donations/1.json
  def show
        render json: @quick_donationdonation, each_serializer: Api::V1::QuickDonationsSerializer 
  end

  # GET /quick_donations/new
  def new
    @quick_donation = QuickDonation.new
  end

  # GET /quick_donations/1/edit
  def edit
  end

  # POST /quick_donations
  # POST /quick_donations.json
  def create
    cookies[:email] = params[:donation][:email]
    cookies[:name] = params[:donation][:name]
    cookies[:tel] = params[:donation][:tel]
    transaction_reference = params[:donation][:reference]
    paystackObj = Paystack.new(ENV['PUBLIC_KEY_TEST'], ENV['SECRET_KEY_TEST'])
    transactions = PaystackTransactions.new(paystackObj)
    result = transactions.verify(transaction_reference)
    if result['data']['status'] == "success"
        @res = result['data']

        @quick_donation = QuickDonation.create(amount: (@res['amount'].to_f)/100,
                      name: cookies[:name],
                      channel: @res['channel'], 
                      reference: @res['reference'], 
                      gateway_response: @res['gateway_response'],
                      currency: @res['currency'],
                      status: @res['status'], 
                      tel: cookies[:tel],
                      email: cookies[:email],
                      created_at: Time.now,
                      updated_at: Time.now)
      @quick_donation.save
    if @quick_donation.save
        render json: @quick_donation, each_serializer: Api::V1::QuickDonationsSerializer 
    else    
        format.json { render :json => @quick_donation.errors, status: :unprocessable_entity}
    end

  else
    format.json { render :json => @quick_donation.errors, status: :unprocessable_entity}
  end
end

  # PATCH/PUT /quick_donations/1
  # PATCH/PUT /quick_donations/1.json
  def update
    respond_to do |format|
      if @quick_donation.update(quick_donation_params)
        format.html { redirect_to @quick_donation, notice: 'Quick donation was successfully updated.' }
        format.json { render :show, status: :ok, location: @quick_donation }
      else
        format.html { render :edit }
        format.json { render json: @quick_donation.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /quick_donations/1
  # DELETE /quick_donations/1.json
  def destroy
    @quick_donation.destroy
    respond_to do |format|
      format.html { redirect_to quick_donations_url, notice: 'Quick donation was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_quick_donation
      @quick_donation = QuickDonation.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def quick_donation_params
      params.require(:quick_donation).permit(:tel, :email, :amount)
    end
end
