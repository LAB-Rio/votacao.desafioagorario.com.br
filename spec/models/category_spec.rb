require 'rails_helper'

RSpec.describe Category, :type => :model do
  
  context "Validations" do
    it { should have_many :proposals }
  end

end
