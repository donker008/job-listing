class AddColumnToJobs < ActiveRecord::Migration[5.0]
  def change
    add_column :jobs, :work_place, :string, :default => "不限"
    add_column :jobs, :work_years, :integer, :default => -1
    add_column :jobs, :education, :string, :default => "不限"
    add_column :jobs, :star1, :integer, :default => 0
    add_column :jobs, :star2, :integer, :default => 0
    add_column :jobs, :star3, :integer, :default => 0
    add_column :jobs, :star4, :integer, :default => 0
    add_column :jobs, :star5, :integer, :default => 0
    add_column :jobs, :company_id, :integer
  end
end
