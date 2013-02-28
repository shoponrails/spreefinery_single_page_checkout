Spree::CheckoutController.class_eval do

  skip_before_filter :check_registration, :only => [:sign_up]

  layout :compute_layout

  def compute_layout
    request.xhr? ? false : ::Refinery::Setting.get(:default_layout)
  end

  def edit
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

  def sign_up
    @user = build_resource(params[:user])
    @order = current_order
    if @user.save
      set_flash_message(:notice, :signed_up)
      sign_in(:user, @user)
      session[:spree_user_signup] = true
      associate_user
      fire_event('spree.checkout.update')

      if @order.next
        redirect_to checkout_path
      else
        flash[:error] = t(:payment_processing_failed)
        respond_with(@order, :location => checkout_state_path(@order.state))
        return
      end
    else
      render :registration
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


  def skip_state_validation?
    %w(sign_up registration update_registration).include?(params[:action])
  end


  protected

  def resource_name
    :user
  end

  def resource
    @resource ||= Refinery::User.new
  end

  def devise_mapping
    @devise_mapping ||= Devise.mappings[:user]
  end

  def build_resource(hash=nil)
    hash ||= params[resource_name] || {}
    instance_variable_set(:"@#{resource_name}", Refinery::User.new_with_session(hash, session))
  end

  def set_flash_message(key, kind, options={})
    options[:scope] = "devise.#{controller_name}"
    options[:default] = Array(options[:default]).unshift(kind.to_sym)
    options[:resource_name] = resource_name
    options = devise_i18n_options(options) if respond_to?(:devise_i18n_options, true)
    message = I18n.t("#{resource_name}.#{kind}", options)
    flash[key] = message if message.present?
  end


end
