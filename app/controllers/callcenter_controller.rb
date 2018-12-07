class CallcenterController < ApplicationController

	def crm_check
		if params[:phone]
			 client = DynamicsCRM::Client.new({organization_name: ENV['ORG_NAME']})
        	 client.authenticate(ENV['USER'], ENV['PASSWORD'])
        	 phone = params[:phone]
        	 res = client.retrieve_multiple('contact', [["mobilephone", "Equal", phone.to_s]])
        	 
        	 if res.entities[0] == nil
        	 		client = DynamicsCRM::Client.new({organization_name: ENV['ORG_NAME']})
       				 client.authenticate(ENV['USER'], ENV['PASSWORD'])
   
        			res = client.create('contact', firstname: "Nil", lastname: "Nil", mobilephone: phone)
      
        			result = res.id

        			redirect_to 'https://nativedge.crm4.dynamics.com:443/main.aspx?etc=2&id='+result+'&histKey=391164297&newWindow=true&pagetype=entityrecord' and return
        	 else	
        	 		result = res.entities[0].id
        	 	
        	 		redirect_to 'https://nativedge.crm4.dynamics.com:443/main.aspx?etc=2&id='+result+'&histKey=391164297&newWindow=true&pagetype=entityrecord' and return

        	 end

        	 
		else
			
		end

	end

end