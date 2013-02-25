Rails.application.routes.prepend do
  match '/checkout/update/:state' => 'spree/checkout#update', :via => :post
  match '/checkout' => 'spree/checkout#edit', :via => :get, :as => :checkout#, :state => 'single_page',
end
