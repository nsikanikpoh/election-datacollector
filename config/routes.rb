Rails.application.routes.draw do
  
 devise_for :users
  resources :reports
  resources :council_wards
   resources :polling_units
  resources :users
  resources :admins
  root 'dashboard#dashboard'
  get 'dashboard/dashboard'
  get '/' => 'dashboard#dashboard'

  get 'house_of_representative_elections' => 'dashboard#rep'
  get 'house_of_representative_elections_by_lga' => 'dashboard#lga_rep'

  get 'presidential_elections' => 'dashboard#presidential'

get 'presidential_elections_by_lga' => 'dashboard#lga_presidential'
  

  get 'senatorial_elections' => 'dashboard#senatorial'


   get 'senatorial_elections_by_lga' => 'dashboard#lga_senatorial'

  get 'house_of_assembly_elections' => 'dashboard#assembly'

   get 'house_of_assembly_elections_by_lga' => 'dashboard#lga_assembly'

  get 'governorship_elections' => 'dashboard#governorship'

    get 'governorship_elections_by_lga' => 'dashboard#lga_governorship'

  get 'sort_votes_by_lga' => 'dashboard#lga'

 
	namespace :api, defaults: {format: 'json'} do 
		namespace :v1 do

		#resources :donations
    #devise_for :users
      resources :users
  	
        resources :reports
        resources :council_wards
        resources :admins
        get 'dashboard' => 'dashboard#dashboard'

        get 'council_wardsa' => 'reports#council_wards'

        resources :sessions, :only => [:create, :destroy]
        resources :passwords, :only => [:create]
	     end

	end


		
end
