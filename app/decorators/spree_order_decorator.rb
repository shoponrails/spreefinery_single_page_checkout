Spree::Order.class_eval do

  checkout_flow do
    go_to_state :single_page
    go_to_state :address
    go_to_state :payment
    go_to_state :confirm
    go_to_state :complete
  end

end
