class Proposal < ActiveRecord::Base
  belongs_to :category


  def image
    !image_url.empty? ? image_url : 'http://i.imgur.com/WzBlGku.png'
  end


  def next
    where('id > ?', id).first || Proposal.first
  end

  def last
    where('id < ?', id).last || Proposal.first
  end
end
