Spree::CheckoutController.class_eval do

  skip_before_filter :check_registration, :only => [:sign_up]

  layout :compute_layout

  def compute_layout
    request.xhr? ? false : ::Refinery::Setting.get(:default_layout)
  end

  def edit
    if @order.state.eql?('cart') and @order.email.present?
      @order.next
      before_address
    end

    if ::Refinery::Setting.find_or_set(:single_page_checkout, true)
      if params[:state].present?
        session[:modify_state] = params[:state]
        redirect_to checkout_path
      else
        if session[:modify_state]
          @order.state = session[:modify_state]
          session[:modify_state] = nil
        end
      end
    end
  end


  private

  def ensure_valid_state
    unless skip_state_validation?
      if (params[:state] && !@order.checkout_steps.include?(params[:state])) ||
          (!params[:state] && !@order.checkout_steps.include?(@order.state))
        unless ::Refinery::Setting.find_or_set(:single_page_checkout, true)
          @order.state = 'cart'
          redirect_to checkout_state_path(@order.checkout_steps.first)
        end
      end
    end
  end
end
