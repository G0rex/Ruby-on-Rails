#---
# Excerpted from "Agile Web Development with Rails",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material,
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose.
# Visit http://www.pragmaticprogrammer.com/titles/rails4 for more book information.
#---
class ApplicationController < ActionController::Base
  before_action :authorize

before_action :set_i18n_locale_from_params
# ...
protected
 def set_i18n_locale_from_params
 if params[:locale]
 if I18n.available_locales.map(&:to_s).include?(params[:locale])
 I18n.locale = params[:locale]
 else
 flash.now[:notice] =
 "#{params[:locale]} translation not available"
 # перевод недоступен
 logger.error flash.now[:notice]
 end
 end
 end

 def default_url_options
 { locale: I18n.locale }
 end
 def authorize
 unless User.find_by(id: session[:user_id])
 redirect_to login_url, notice: "Пожалуйста, пройдите авторизацию"
 end
 end
  protect_from_forgery with: :exception
end
