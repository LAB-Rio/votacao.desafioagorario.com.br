class ProposalsController < ApplicationController
  respond_to :html

  def index
    @proposals = Proposal.all
  end

  def show
    @proposal = Proposal.find_by(id: params[:id])
  end
end
