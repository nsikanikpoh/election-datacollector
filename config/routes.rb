Rails.application.routes.draw do
  
  mount Ckeditor::Engine => '/ckeditor'
  resources :conversations
  resources :quick_donations
  resources :pics
  resources :collages
  root 'dashboard#dashboard'
  get 'dashboard/dashboard'
  get '/' => 'dashboard#dashboard'
  get 'makepayment' => 'donations#makepayment'
  resources :interest_lines
  resources :comments
  resources :fund_raisers
  resources :prospects

  resources :champions
  resources :patriots

   resources :ambassadors
  resources :sponsorships
  resources :posts
  resources :affiliations
  resources :donations
  devise_for :users, :controllers => { :registrations => "users/registrations", :omniauth_callbacks =>"users/omniauth" }
  resources :admins

  resources :prospects do
            member do
              get 'oppotunity'
              get 'prospect_conversations'
            end
  end
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resources :users do
  	member do
      get 'api_token'
    
  end
  end

   resources :interest_lines do
    member do
      get 'addinterest'
    
  end
  end

    get 'fundraiser_conversations' => 'conversations#fundraiser_conversations'
    get 'my_downlines' => 'dashboard#downlines'
    get 'my_prospects' => 'prospects#my_prospects'
    get 'donation_history' => 'donations#donation_history'
    get 'sponsorship_history' => 'sponsorships#sponsorship_history'

    get 'upgrade' => 'donations#upgrade'
   get 'join_now' => 'join_now#index'
    get 'crm_check' => 'callcenter#crm_check'
    get 'donate_for_prospect' => 'donations#donate_for_prospect'
    get 'qualifies' => 'prospects#qualifies'

    get 'opportunities' => 'prospects#opportunities'
    get 'donated' => 'prospects#donated'

  resources :members
	root 'dashboard#dashboard'
	get 'dashboard/dashboard'
	patch 'dashboard/accountupdate'

resources :posts do
  member do
      get 'download_file'
      get 'comment'
  end
end
resources :comments do
  member do   
      get 'download_file'
  end
end

resources :pics do
  member do   
      get 'download_file'
  end
end

  resources :posts do
  	resources :comments
  end

 resources :prospects do
    resources :conversations
  end

  resources :collages do
    resources :pics
  end



	namespace :api do 
		namespace :v1 do

    resources :collages,only: [:show, :index]
     
		#resources :donations
    #devise_for :users
      resources :users, :only => [:update]
  	 resources :quick_donations
   		resources :members, :only => [:show, :create, :update, :destroy]
      resources :sessions, :only => [:create, :destroy]
      resources :passwords, :only => [:create]
      
  resources :interest_lines do
    member do
      get 'addinterest'
    
  end
  end
      resources :interest_lines
        resources :comments
      resources :fund_raisers
      resources :prospects
       resources :sponsorships
      resources :posts
        resources :affiliations
        
        resources :donations

        get 'myinterest' => 'interest_lines#myinterest'

        get 'dashboard' => 'dashboard#dashboard'

        get 'my_downlines' => 'dashboard#downlines'

          get 'my_prospects' => 'prospects#my_prospects'
          get 'qualifies' => 'prospects#qualifies'
         
          get 'post_comments' => 'comments#post_comments'
          get 'collage_comments' => 'pics#collage_comments'
           get 'donation_history' => 'donations#donation_history'
             get 'sponsorship_history' => 'sponsorships#sponsorship_history'
           post 'fundraiser_donate' => 'donations#fundraiser_donate'
         get 'upgrade' => 'donations#upgrade'

         get 'donated' => 'prospects#donated'
          get 'opportunities' => 'prospects#opportunities'

         get 'amount_raised' => 'prospects#amount_raised'
         get 'fundraiser_conversations' => 'conversations#fundraiser_conversations'
       resources :posts do
              member do
               get 'download_file'
              get 'comment'
          end
        end

        resources :users do
            member do
              get 'profile'
            end
        end

        resources :prospects do
            member do
              get 'oppotunity'
              get 'prospect_conversations'
            end
        end

        resources :posts do
            resources :comments
         end

      resources :comments do
                member do   
                 get 'download_file'
              end
            end
	     end

	end


		
end
