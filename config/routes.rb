Rails.application.routes.draw do

  root 'welcome#index'
  resources :passwords, controller: "clearance/passwords", only: [:create, :new]
  resource :session, controller: "clearance/sessions", only: [:create]

  resources :users, controller: "users", only: [:create, :new, :edit, :update, :show] do
    resource :password,controller: "clearance/passwords",only: [:create, :edit, :update] 
  end

  resources :listings, controller: "listings" do 
    resources :reservations, except: [:index], controller: "reservations"
  end 

  get "/sign_in" => "clearance/sessions#new", as: "sign_in"
  delete "/sign_out" => "clearance/sessions#destroy", as: "sign_out"
  get "/sign_up" => "users#new", as: "sign_up"
  get "/mylistings" => "listings#mylistings", as: "my_listings"
end


# session has no :id therefore it is just park under resource 
# resources provides the 7 restful routes 

# resource: book || session || listing || user
# 7 restful routes

# new => a form to a new resource
# create => sending information from new form to create 
# index => show all the resource
# show => show one particular resource
# edit => to show a form to edit a resource
# update => sending information from edit form to edit 
# resource

# delete => to delete a resource

#redirect_to sign_in_path relates to /sign_in 


