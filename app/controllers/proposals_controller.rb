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

    if params[:existing]
      current_user.proposals = []
      current_proposals = session[:proposal_ids]
    else
      current_proposals = proposals_params[:user_proposals] 
    end

    session[:proposal_ids] = current_proposals 

    @proposals = current_user.proposals
    @new_proposals = find_proposals(current_proposals)
    
    return render :already_saved if @proposals.any?

    @new_proposals.each_with_index do |proposal, index|
      return render :success if index > 9
      current_user.proposals << proposal
    end
    
    render :success
  end

  def already_saved
  end

  def success
  end

  private
    def find_proposals(ids)
      proposals = []
      ids.each do |prop|
        proposals << Proposal.find_by(id: prop)
      end
      return proposals
    end

    def proposals_params
      params.require(:proposals).permit(user_proposals: [])
    end
end
