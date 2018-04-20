class Tag < ApplicationRecord
  belongs_to :photo

  def self.search(term)
    if term
      where('tag LIKE ?', "%#{term}%").order('id DESC')
    else
      order('id DESC')
    end
  end
end
