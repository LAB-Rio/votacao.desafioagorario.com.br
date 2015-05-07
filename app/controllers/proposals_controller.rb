class ProposalsController < ApplicationController
  respond_to :html

  def index
    @proposals = Proposal.all
  end

  def show
    @proposal = Proposal.find_by(id: params[:id])
  end


  def save 
    
    if params[:existing]
      current_user.proposals = []
      current_proposals = session[:proposal_ids]
    else
      current_proposals = proposals_params[:user_proposals] 
    end

    session[:proposal_ids] = current_proposals

    authenticate_user!


    @proposals = current_user.proposals
    @new_proposals = find_proposals(current_proposals)
    
    if @proposals.any?
      return render :already_saved 
    end

    @new_proposals.each_with_index do |proposal, index|
      if index > 9
        return render :success
      end
      current_user.proposals << proposal
    end
   
    render :success
  end

  def already_saved; end

  def success;end

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
