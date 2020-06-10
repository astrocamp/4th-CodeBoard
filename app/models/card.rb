class Card < ApplicationRecord
  acts_as_paranoid

  belongs_to :board
  has_many :records
  has_many :user, through: :records

  validates :title, presence: true
  validates :level, presence: true
  validates :result, presence: true

  before_update :check_before_modify!
  before_destroy :check_before_modify!

  def self.search_by(search_term)
    if search_term
      where("LOWER(title) LIKE :search_term",
      search_term: "%#{search_term.downcase}%")
    else
      all
    end
  end

  private
  def check_before_modify!
    if self.records.exists?
      errors.add :base, "很抱歉！已有答題紀錄，您無法進行題目修改"
      throw(:abort)
    end
  end

end
