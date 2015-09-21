class Proposal < ActiveRecord::Base
  belongs_to :category
  has_and_belongs_to_many :users, -> { uniq }

  def image
    !image_url.empty? ? image_url : 'http://i.imgur.com/r9gMLrx.jpg'
  end


  def next
    Proposal.where('id > ?', id).first || Proposal.first
  end

  def prev 
    Proposal.where('id < ?', id).last || Proposal.first
  end


  def to_param
    "#{id}-#{title.parameterize}"
  end


  def ap_zone
    case zone
    when "AP1" then "Centro"
    when "AP2" then "Zona Sul"
    when "AP3" then "Zona Norte"
    when "AP4" then "Jacarépagua/Barra"
    when "AP5" then "Zona Oeste"
    end
  end
end
