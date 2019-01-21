class CrmsponsorJob < ApplicationJob
  queue_as :default

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

  def perform(donation)
    # Do something later
         sexint = getGender(current_user)
        client = DynamicsCRM::Client.new({organization_name: ENV['ORG_NAME']})
        client.authenticate(ENV['USER'], ENV['PASSWORD'])
   
        #amount = BigDecimal.new(@donation.amount.to_i)
         
          crmid = client.create('new_donation', new_amountdonated: donation.amount.to_i,
          new_interestline: {type: "OptionSetValue", value: sexint})

          contacts = [ DynamicsCRM::XML::EntityReference.new("new_donation", crmid.id)]
          client.associate("contact", donation.donator.crm_id, "new_contact_new_donation_Donator", contacts)

  end


end
