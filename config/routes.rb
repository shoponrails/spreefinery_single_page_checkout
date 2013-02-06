Rails.application.routes.prepend do
  match '/checkout' => 'spree/checkout#edit', :state => 'single_page', :as => :checkout
end
