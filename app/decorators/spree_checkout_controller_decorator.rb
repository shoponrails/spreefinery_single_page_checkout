Spree::CheckoutController.class_eval do
  respond_to :html, :js

  layout :compute_layout

  skip_before_filter :check_registration, :only => [:edit]

  def compute_layout
    request.xhr? ? false : ::Refinery::Setting.get(:default_layout)
  end

  def skip_state_validation?
    true#%w(single_page guest registration).include?(@order.state)
  end

  def before_single_page

  end

  def before_guest

  end

  def before_registration
    if params[:user]
      @user = Refinery::User.new(params[:user])
      if @user.save
        sign_in(:user, @user)
        session[:spree_user_signup] = true
        associate_user
        @order.email = @user.email
        @order.state = 'address'

        if @order.update_attributes(object_params)
          fire_event('spree.checkout.update')
          state_callback(:after)
        end

      end
    end
  end

end
