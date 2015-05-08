class AdminUser < ActiveRecord::Base
  include Typus::Orm::ActiveRecord::AdminUser
  def self.locales
    Typus::I18n.available_locales
  end
end
