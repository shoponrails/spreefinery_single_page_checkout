Rails.application.routes.prepend do
  match '/checkout' => 'spree/checkout#edit', :as => :checkout#, :state => 'single_page',
end
