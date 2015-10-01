class ProposalsController < ApplicationController
  respond_to :html
  
  before_filter do
    redirect_to root_path unless params[:grillo]
  end

  def index
    @proposals = Proposal.includes(:users).order('fullname ASC')
  end

  def show
    @proposal = Proposal.find_by(id: params[:id])
  end


  def save 
    current_proposals = proposals_params[:user_proposals] 

    session[:proposal_ids] = current_proposals

    redirect_to proposals_path if current_proposals.blank? 

    authenticate_user!

    @new_proposals = find_proposals(current_proposals)

    @new_proposals.each_with_index do |proposal, index|
      unless current_user.proposals.include?(proposal) && current_user.proposals.count < 101
        current_user.proposals << proposal 
      end
    end
   
    render :success
    session[:proposal_ids] = nil
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
