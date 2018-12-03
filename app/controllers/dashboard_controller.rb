class DashboardController < ApplicationController
  
   def amount_raised
    @amountd = 0
    donations ||= []
      @donors ||= []
      users = User.all
      dons = Donation.where(type: [nil, ""])
      users.each do |p|
            if p.fundraiser_email == current_user.email
               
                 if p.type == "Member" || p.type == "User" || p.type == "Patriot" || p.type == "Champion" || p.type == "Ambassador"
                     @donors << p
                  end
            end
          end
       
      
           
        dons.each do |d|
          
          @donors.each do |e|
            if d.donator_id == e.id
               @amountd += d.amount
            end
        end
      end
  end


  def opportunities
       @userso ||= []
        prospects = Prospect.all
        if prospects
        prospects.each do |p|
            if p.opportunity == "Found"
                 if p.fundraiser_email == @current_user.email
                    @userso << p
                  end
            end

        end
      end
    end

   

  def fundraiser_workflows
      amount_raised
      opportunities
    if current_user.fund_raiser?
      if current_user.prospects.any?

        d = current_user.prospects.last.created_at.to_s.split(' ')
        contacts = current_user.prospects.count
        @last_contact = current_user.prospects.last.name
        @date_added = d[0]
        @time_added = d[1]
        @last_contact_op = current_user.prospects.last.opportunity
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

 def admin
  if current_user.admin?
    @prospects = Prospect.all
    @fund_raisers = FundRaiser.all
    @patriots = Patriot.all
    @champions = Champion.all
    @ambassadors = Ambassador.all
    @members = Member.all
    @donations = Donation.where(type: [nil, ""])
    @events = Sponsorship.all
    @qds = QuickDonation.all
    @posts = Post.all
    @users = User.all
    @interests = InterestLine.all
  end
 end 

 def sponsorship_history
  if current_user.patriot?
     @sponsorships ||=[]
   # storage for referrals and affilations through eight generations
   @dons = Sponsorship.all
   if @dons
      @dons.each do |u| 
    if u.donator_id == current_user.id
      
       @sponsorships << u
    
    end
   end
  end
  end
end

  def dashboard
    sponsorship_history
    admin
    fundraiser_workflows
    @user = current_user
    

    @donation = Donation.new()
    @donations ||=[]
    @amount = 0
     @samount = 0
   # storage for referrals and affilations through eight generations
   @dons = Donation.where(type: [nil, ""])
    if @dons
      @dons.each do |u| 
           if u.donator_id == current_user.id
      
              @donations << u
    
           end
      end
   end

    if @donations
        @donations.each do |u| 
              @amount += u.amount
           end
    end

     if @sponsorships
        @sponsorships.each do |u| 
              @samount += u.amount
           end
    end
  
   if @donations.any?

    @donates = @donations

    d = @donations.last.created_at.to_s.split(' ')
    @user_donations_count = @donations.count
    @last_donation_due = @donations.last.expires_on
    rem = (@last_donation_due - Date.today).to_s.split('/')
    @last_donation_date = d[0]
    @last_donation_time = d[1]
     @last_donation_rem = rem[0]
    @last_donation_amount = @donations.last.amount
    @last_donation_type = @donations.last.line
  else
    @user_donations_count = 0
    @last_donation_due = "Nil"
    @last_donation_date = "Nil"
    @last_donation_time = "Nil"
    @last_donation_amount = 0
     @last_donation_type = "Nil"
     @last_donation_rem = "Nil"
  end

    #generate first generation referrals

    @firstgeners = referral_gen(current_user)

    @secondgeners ||= []
     
    @thirdgeners ||= []
      
    @fourthgeners ||= []
    
    @fifthgeners ||= []
    
    @sixthgeners ||= []
    
    @seventhgeners ||= []
   
    @eightgeners ||= []
  
    @users = User.all


     if @firstgeners.any?
      @firstgeners.each do |u|
      @users.each do |e|
        if e.referrer_code == u.affiliate_code
          @secondgeners.push(e)
        end
      end
    end
end
  

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

  
#create a chart virsualization
@chartamounts ||= []
@dates ||= []

 if @donations
    @donations.each do |e|

      @chartamounts << {value: e.amount.to_s}
      d = e.created_at.to_s.split(' ')
      @dates << {label: d[0]}      
    end
end
  @chart = Fusioncharts::Chart.new({
        width: "600",
        height: "400",
        type: "msline",
        renderAt: "chartContainer",
        dataSource: {
            chart: {
            caption: "Donations virsualization graph",
            subCaption: "OneMilMap Commitment",
            xAxisname: "Dates",
            yAxisName: "Amount (₦)",
            numberPrefix: "₦",
            theme: "zune",
            exportEnabled: "1",
            palette: 3,
            palettecolors: "FB8C00",
            divlineColor: "#999999",
            lineColor: "#ff0000",
            nullentityfillcolor: "#757DE8",
            basefontcolor: "#2A3F54",
            animation: 1,
            divLineIsDashed: "1"
            },

            categories: [{
                    category: @dates
                        
                    
                }],
                dataset: [
                   
                    {
                        seriesname: "Donation Dates",
                        data: @chartamounts
                          
                        
                    }
              ]
        }
    })

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

def getGender(user)
    if user.gender == "Female"
          return 100000001
        elsif user.gender == "Male"
          return 100000000
        end
end


def getType(user)
      if user.type == "Member"
          return 100000000
      elsif user.type == "FundRaiser"
          return 100000003
      end
end


def accountupdate
  	@user = current_user
  	@user.update(user_params)
  	respond_to do |format|
      if @user.update(user_params)
        code = @user.id + 24523009
        @user.update(affiliate_code: code)
         url = "https://localhost:3000/members/new/?referrer_code=#{@user.affiliate_code}"
      	 @user.update(url: url)
        namel =@user.name.split(' ')
        fname = namel[0]
        lname = namel[1]

        sexint = getGender(@user)
        typeint = getType(@user)
        
        client = DynamicsCRM::Client.new({organization_name: ENV['ORG_NAME']})
        client.authenticate(ENV['USER'], ENV['PASSWORD'])
   
        res = client.create('contact', firstname: fname, lastname: lname, emailaddress1: @user.email, 
          gendercode: {type: "OptionSetValue", value: sexint}, mobilephone: @user.phone, 
          address1_stateorprovince: @user.state, new_supportertype: {type: "OptionSetValue", value: typeint})
       crmid = res.id
        @user.update(crm_id: crmid)

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
      params.require(:user).permit(:type, :name, :email, :gender, :phone, :location, :state)
    end

end
