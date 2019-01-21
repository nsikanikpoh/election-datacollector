class CrmdonateJob < ApplicationJob
  queue_as :default
  def getType(user)
      if user.line == "monthly"
          return 100000000
      elsif user.line == "quarterly"
          return 100000001

      elsif user.line == "yearly"
          return 100000002
      end

end

  def perform(donation, crm_id)
    # Do something later
      client = DynamicsCRM::Client.new({organization_name: ENV['ORG_NAME']})
        client.authenticate(ENV['USER'], ENV['PASSWORD'])
   
        #amount = BigDecimal.new(@donation.amount.to_i)

          dtype = getType(donation)
          crmid = client.create('new_donation', new_amountdonated: donation.amount.to_i,
          new_donationtype: {type: "OptionSetValue", value: dtype})

          contacts = [ DynamicsCRM::XML::EntityReference.new("new_donation", crmid.id)]
          client.associate("contact", crm_id, "new_contact_new_donation_Donator", contacts)

  end
end
