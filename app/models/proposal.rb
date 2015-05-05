class Proposal < ActiveRecord::Base
  belongs_to :category


  def image
    !image_url.empty? ? image_url : 'http://i.imgur.com/WzBlGku.png'
  end
end
