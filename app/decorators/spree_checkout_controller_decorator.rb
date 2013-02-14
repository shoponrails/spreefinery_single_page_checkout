Spree::CheckoutController.class_eval do

  layout :compute_layout

  skip_before_filter :check_registration, :only => [:edit]

  def compute_layout
   params[:action].eql?("edit") ? ::Refinery::Setting.get(:default_layout) : false
  end


  def before_single_page

    unless @order.bill_address or @order.ship_address
      last_used_bill_address, last_used_ship_address = SpreeLastAddress.find_last_used_addresses(@order.email)
      preferred_bill_address, preferred_ship_address = current_refinery_user.bill_address, current_refinery_user.ship_address if current_refinery_user.respond_to?(:bill_address) && current_refinery_user.respond_to?(:ship_address)
      @order.bill_address ||= preferred_bill_address || last_used_bill_address || Spree::Address.default
      @order.ship_address ||= preferred_ship_address || last_used_ship_address || Spree::Address.default
    end

    #@order.shipping_method ||= (@order.rate_hash.first && @order.rate_hash.first[:shipping_method])
    @order.payments.destroy_all if request.put?
  end

end
