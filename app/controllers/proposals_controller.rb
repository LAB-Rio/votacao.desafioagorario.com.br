class ProposalsController < ApplicationController
  respond_to :html

  def index
    @proposals = Proposal.order('RANDOM()').all
  end

  def show
    @proposal = Proposal.find_by(id: params[:id])
  end


  def associate
    @proposal = Proposal.find_by(id: params[:id])

    if current_user.proposals.include?(@proposal)
      current_user.proposals << @proposal
    else
      current_user.delete(@proposal)
    end
  end
end
