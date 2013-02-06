Spree::CheckoutController.class_eval do

  layout :compute_layout

  skip_before_filter :check_registration, :only => [:edit]

  def compute_layout
   params[:action].eql?("edit") ? ::Refinery::Setting.get(:default_layout) : false
  end


  def before_single_page
    @order.bill_address ||= Spree::Address.default
    @order.ship_address ||= Spree::Address.default
    #@order.shipping_method ||= (@order.rate_hash.first && @order.rate_hash.first[:shipping_method])
    @order.payments.destroy_all if request.put?
  end

end
