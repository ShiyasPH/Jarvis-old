class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController
  ORG_EMAIL_DOMAIN = 'codeastra.com'.freeze

  def google_oauth2
    if org_email_auth?
      @user = User.from_omniauth(request.env["omniauth.auth"])
      if @user.persisted?
        sign_in @user, :event => :authentication #this will throw if @user is not activated
      else
        session["devise.google_data"] = request.env["omniauth.auth"]
      end
    else
      flash[:alert] = I18n.t('login.org_auth_failure')
    end

    redirect_to root_path
  end

  private

  def org_email_auth?
    request.env["omniauth.auth"].info.email.split('@').last == ORG_EMAIL_DOMAIN
  end
end