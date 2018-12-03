
namespace :recurring do
desc 'Upgrage Members to Champions and Patriot respectively!'
  task init: :environment do
    UpgradeTask.schedule!
  end
end