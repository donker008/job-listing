class Job < ApplicationRecord
  validates :title, presence:true
  validates :description, presence:true
  validates :salaryMin, presence:true , numericality:{greater_than:0}
  validates :salaryMax, presence:true , numericality:{greater_than:0}
  validates :work_years, presence:true
  validates :work_place, presence:true
  validates :education, presence:true


  belongs_to :user
  has_many :resumes
  has_many :comments
  belongs_to :company

  ransack_alias :searchjob, :title_or_description


  self.per_page = 3

def work_years_format
  if self.work_years <= -1
    return "经验不限"
  elsif self.work_years == 0
    return "应届毕业"
  else
    return "经验" + self.work_years.to_s + "年"
  end
end

def salary_format
   number_to_k(self.salaryMin).to_s + "K-" + number_to_k(self.salaryMax).to_s + "K"
end

def relase_date_format
  if self.created_at.today?
      self.created_at.strftime("%H:%M")
  elsif self.created_at.yesterday
    "昨天 " + self.created_at.strftime("%H:%M")
  else
      self.created_at.strftime("%m/%d")
  end
end

def work_place_format(places)
    return places[self.work_place.to_i-1].name
end

private

def number_to_k(number)
  k =  number / 1000
  if k <= 0
    k = 1;
  end
  return k
end

end
