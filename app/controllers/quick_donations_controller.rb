class QuickDonationsController < ApplicationController
  before_action :set_quick_donation, only: [:show, :edit, :update, :destroy]
   skip_before_action :authenticate_user!, only: [:new, :create, :show]
   layout 'application', only: [:index]
  # GET /quick_donations
  # GET /quick_donations.json
  def index
    @quick_donations = QuickDonation.all.paginate(page: params[:page], per_page: 5).order(created_at: :desc, id: :desc)
  end

  # GET /quick_donations/1
  # GET /quick_donations/1.json
  def show
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
    cookies[:email] = quick_donation_params[:email]
    cookies[:name] = quick_donation_params[:name]
    cookies[:tel] = quick_donation_params[:tel]

    ref = SecureRandom.hex
    cookies[:ref] = ref
    namel = quick_donation_params[:name].split(' ')
    fname = namel[0]
    lname = namel[1]
    paystackObj = Paystack.new(ENV['PUBLIC_KEY_TEST'], ENV['SECRET_KEY_TEST'])
    transactions = PaystackTransactions.new(paystackObj)
    result = transactions.initializeTransaction(
    :reference => ref,
    :amount => quick_donation_params[:amount].to_i*100,
    :email => quick_donation_params[:email],
    :firstname => fname,
    :lastname => lname
    )
    
    auth_url = result['data']['authorization_url']

    redirect_to auth_url


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
      params.require(:quick_donation).permit(:name, :tel, :email, :amount)
    end
end
