class DonationsController < ApplicationController
  before_action :set_donation, only: [:show, :edit, :update, :destroy]
  skip_before_action :authenticate_user!, only: [:makepayment]
  # GET /donations
  # GET /donations.json
  def index
    @donations = Donation.where(type: [nil, ""]).paginate(page: params[:page], per_page: 5).order(created_at: :desc, id: :desc)
  end

  def donation_history
     @donations ||=[]
   # storage for referrals and affilations through eight generations
   @dons = Donation.where(type: [nil, ""])
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
    @donation = Donation.new()
  end

  def getGender(user)
    if user.interest_line.name == "Education"
          return 100000000
        elsif user.interest_line.name == "Health"
          return 100000001
        elsif user.interest_line.name == "Women's Right"
          return 100000002
          elsif user.interest_line.name == "Conflicts and Emergencies"
          return 100000003
          elsif user.interest_line.name == "Food and Agriculture"
          return 100000004

          elsif user.interest_line.name == "Governance"
          return 100000005

        end
end

def insert_to_crm1(donation)
        sexint = getGender(current_user)
        client = DynamicsCRM::Client.new({organization_name: ENV['ORG_NAME']})
        client.authenticate(ENV['USER'], ENV['PASSWORD'])
   
        #amount = BigDecimal.new(@donation.amount.to_i)
         
          crmid = client.create('new_donation', new_amountdonated: donation.amount.to_i,
          new_interestline: {type: "OptionSetValue", value: sexint})

          contacts = [ DynamicsCRM::XML::EntityReference.new("new_donation", crmid.id)]
          client.associate("contact", donation.donator.crm_id, "new_contact_new_donation_Donator", contacts)

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

  def makepayment
    transaction_reference = params[:trxref]
    paystackObj = Paystack.new(ENV['PUBLIC_KEY_TEST'], ENV['SECRET_KEY_TEST'])
    transactions = PaystackTransactions.new(paystackObj)
    result = transactions.verify(transaction_reference)
    if result['data']['status'] == "success"
        @res = result['data']
        if current_user
            if cookies[:line].to_i == 0
                expires_on = Date.today + 30.days
            elsif cookies[:line].to_i == 1

                expires_on = Date.today + 90.days

            elsif cookies[:line].to_i == 2
                expires_on = Date.today + 365.days
            end

            if cookies[:donator_id]
                user = User.find(cookies[:donator_id].to_i)
                if (@res['amount'].to_f)/100 >= 24000
                    user.update(type: "Patriot", s_type: "Patriot")
                else
                    user.update(type: "Member", s_type: "Member")
                end
                donation = Donation.create(amount: (@res['amount'].to_f)/100,
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
                
                CrmdonateJob.set(wait: 20.seconds).perform_later(donation, user)

            else
                  if cookies[:interest_line]

                      donation = Sponsorship.create(amount: (@res['amount'].to_f)/100,
                    interest_line_id: cookies[:interest_line].to_i,
                    channel: @res['channel'], 
                    reference: @res['reference'], 
                    gateway_response: @res['gateway_response'],
                    currency: @res['currency'],
                    donator_id: current_user.id,
                    donator_type: current_user.type,
                    status: @res['status'],
                    created_at: Time.now,
                    updated_at: Time.now)
                      insert_to_crm1(donation)
                      CrmsponsorJob.set(wait: 20.seconds).perform_later(donation, current_user)


                       donation.save
                        respond_to do |format|
                            if donation.save
       
                                format.html { redirect_to sponsorship_path(donation.id), notice: 'You have successfully created a sponsorship, Thanks for your Support.' and return }
                             else
                                format.html { redirect_to new_sponsorship_path, notice: 'Payment Failed. Please try again'and return }
                              end
                          end


                  else

                    donation = Donation.create(amount: (@res['amount'].to_f)/100,
                    line: cookies[:line].to_i,
                    channel: @res['channel'], 
                    reference: @res['reference'], 
                    gateway_response: @res['gateway_response'],
                    currency: @res['currency'],
                    donator_id: current_user.id,
                    donator_type: current_user.type,
                    status: @res['status'], 
                    expires_on: expires_on,
                    created_at: Time.now,
                    updated_at: Time.now)
                     CrmdonateJob.set(wait: 20.seconds).perform_later(donation, current_user)

                        if (@res['amount'].to_f)/100 >= 24000
                            if current_user.type == "Member" || current_user.type == "Champion" 
                                current_user.update(type: "Patriot", s_type: "Patriot")
                            end
                         else

                              if current_user.type == "Member"
                                current_user.update(type: "Champion", s_type: "Champion")
                    
                              elsif current_user.type == "Patriot"
                      
                                  current_user.update(type: "Member", s_type: "Member")
                    
                              end
                         end

                  end

            end
            donation.save
            respond_to do |format|
              if donation.save
       
                  format.html { redirect_to donation, notice: 'Your donation was successful, Thanks for your Support.' }
              else
                format.html { redirect_to new_donation_path, notice: 'Payment Failed. Please try again' }
              end
            end

        else

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
    respond_to do |format|
      if @quick_donation.save
        format.html { redirect_to @quick_donation, notice: 'Your donation was successful, Thanks for your Support.' }
      else
        format.html { redirect_to new_quick_donation_path, notice: 'Payment Failed. Please try again.'}
       end
    end

          
        end

    else
      redirect_to root_path, notice: 'Payment Failed. Please try again'
    end

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

  def upgrade
    @donation = Donation.new()
  end
  # GET /donations/1/edit
  def edit
  end
  

  def donate_for_prospect
      if current_user.fund_raiser?
          @donation = Donation.new()
          @prospects = current_user.prospects        
      else
          redirect_to root_path, notice: 'You are not a Fund Raiser on this system'
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
    if donation_params[:donator_id]

      cookies[:donator_id] = donation_params[:donator_id].to_i
    end
    
    cookies[:line] = donation_params[:line].to_i
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
