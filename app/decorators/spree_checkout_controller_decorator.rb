Spree::CheckoutController.class_eval do
  respond_to :html, :js

  layout :compute_layout

  skip_before_filter :check_registration, :only => [:edit]

  def compute_layout
   @order.state.eql?("cart") ? ::Refinery::Setting.get(:default_layout) : false
  end

  def skip_state_validation?
    true
  end

  def before_registration

  end

end
