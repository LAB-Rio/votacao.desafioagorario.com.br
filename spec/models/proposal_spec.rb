require 'rails_helper'

RSpec.describe Proposal, :type => :model do
  context "Validations" do
    it { should belong_to :category }
  end


end
