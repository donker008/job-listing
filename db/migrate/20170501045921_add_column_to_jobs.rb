class AddColumnToJobs < ActiveRecord::Migration[5.0]
  def change
    add_column :jobs, :work_place, :string
    add_column :jobs, :work_years, :integer, :default => -1
    add_column :jobs, :education, :string
    add_column :jobs, :star1, :integer
    add_column :jobs, :star2, :integer
    add_column :jobs, :star3, :integer
    add_column :jobs, :star4, :integer
    add_column :jobs, :star5, :integer
    add_column :jobs, :company_id, :integer
  end
end
