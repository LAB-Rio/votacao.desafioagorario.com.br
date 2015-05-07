class ProposalsController < ApplicationController
  respond_to :html

  def index
    @proposals = Proposal.all
  end

  def show
    @proposal = Proposal.find_by(id: params[:id])
  end


  def save 
    authenticate_user!
   
    

    if current_user.proposals.include?(@proposal)
      current_user.proposals << @proposal
    else
      current_user.delete(@proposal)
    end
  end


  def proposals_params
    params.require(:proposals).permit(:user_proposals_attributes)
  end
end
