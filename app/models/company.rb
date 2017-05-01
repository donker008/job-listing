class Company < ApplicationRecord
  validates :name, presence:true
  validates :industry, presence:true
  validates :description, presence:true
  has_many :jobs

end
