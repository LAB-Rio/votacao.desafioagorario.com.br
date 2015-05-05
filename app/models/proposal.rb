class Proposal < ActiveRecord::Base
  belongs_to :category
  has_and_belongs_to_many :users

  def image
    !image_url.empty? ? image_url : 'http://i.imgur.com/WzBlGku.png'
  end


  def next
    Proposal.where('id > ?', id).first || Proposal.first
  end

  def prev 
    Proposal.where('id < ?', id).last || Proposal.first
  end
end
