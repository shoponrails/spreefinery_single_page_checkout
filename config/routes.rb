Rails.application.routes.prepend do
  #match '/checkout' => 'spree/checkout#edit', :via => :get, :as => :checkout#, :state => 'single_page'
end

Spree::Core::Engine.routes.prepend do
  match '/checkout/update/:state' => 'checkout#update', via: :post
end
