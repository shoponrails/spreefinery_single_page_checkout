Rails.application.routes.prepend do
  #match '/checkout' => 'spree/checkout#edit', :via => :get, :as => :checkout#, :state => 'single_page'
end

Spree::Core::Engine.routes.prepend do
  match '/checkout/sign_up' => 'checkout#sign_up', :via => :put, :as => :checkout_sign_up
  match '/checkout/update/:state' => 'checkout#update', via: :post
end
