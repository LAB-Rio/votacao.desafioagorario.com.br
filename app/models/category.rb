class Category < ActiveRecord::Base
  has_many :proposals
end
