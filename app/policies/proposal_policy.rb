class ProposalPolicy < ApplicationPolicy


  def vote?
    !user.empty?
  end


end
