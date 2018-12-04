class UpgradeTask
  include Delayed::RecurringJob
  run_every 1.day
  run_at '11:10am'
  timezone 'Africa/Lagos'
  queue 'slow-jobs'
  def perform
    members = Members.all
    amount = 0
     one_year_donations ||= []
    	members.each do |f|
  			if f.donations.any?
          all_donations = f.donations
          all_donations.each do |d|
    			   if d.created_at <= (d.created_at + 1.year)
                one_year_donations.push(d)
              end
          end
          if one_year_donations.any?
           one_year_donations.each do |s|
              amount += s.amount
          end
        end

          if amount >= 24000
              f.update(type: "Patriot")
          else
            f.update(type: "Champion")                   
          end
    
  		end
  	end

 end
end
