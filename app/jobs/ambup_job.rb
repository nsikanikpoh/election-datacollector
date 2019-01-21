class AmbupJob < ApplicationJob
  queue_as :default

   def getGender(user)
    if user.gender == "Female"
          return 2
     elsif user.gender == "Male"
          return 1
     end
end

def geo_zone(state)
  north_central = ["Benue","FCT","Kogi","Kwara","Nassarawa","Niger","Plateau"]
  north_east = ["Adamawa","Bauchi","Borno","Gombe","Taraba","Yobe"]
  north_west = ["Jigawa","Kaduna","Kano","Katsina","Kebbi","Sokoto","Zamfara"]
  south_south = ["Akwa Ibom","Bayelsa","Cross River","Delta","Edo","Rivers"]
  south_east = ["Abia","Anambra","Ebonyi","Enugu","Imo"]
  south_west = ["Ekiti","Lagos","Ogun","Ondo","Osun","Oyo",]
       if north_central.include?(state)
          return 100000000
        elsif north_east.include?(state)
          return 100000001
        elsif north_west.include?(state)
          return 100000002
        elsif south_south.include?(state)
          return 100000005
        elsif south_west.include?(state)
          return 100000004

        elsif south_east.include?(state)
          return 100000003
        end

end


  def perform(user)
    # Do something later
    namel = user.name.split(' ')
        fname = namel[0]
        lname = namel[1]

          sexint = getGender(user)
          geoint = geo_zone(@user.state)
          typeint = 100000003
          
        client = DynamicsCRM::Client.new({organization_name: ENV['ORG_NAME']})
        client.authenticate(ENV['USER'], ENV['PASSWORD'])
   
        res = client.create('contact', firstname: fname, lastname: lname, emailaddress1: user.email, 
          gendercode: {type: "OptionSetValue", value: sexint}, mobilephone: user.phone, 
          address1_stateorprovince: user.state, new_geopoliticalzone: {type: "OptionSetValue", value: geoint}, new_supportertype: {type: "OptionSetValue", value: typeint})
      
        crmid = res.id
        user.update(crm_id: crmid)

  end
end
