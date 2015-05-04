class Proposal < ActiveRecord::Base
  belongs_to :category


  def image
    !image_url.empty? ? image_url : 'http://placehold.it/300x200'
  end
end
