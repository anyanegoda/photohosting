class Tag < ApplicationRecord
  belongs_to :photo

  def self.search(term)
    if term
      where('tag LIKE ?', "%#{term}%")
    else
      all
    end
  end
end
