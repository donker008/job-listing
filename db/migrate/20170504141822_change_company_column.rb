class ChangeCompanyColumn < ActiveRecord::Migration[5.0]
  def change
      change_column :companies, :description, :text
  end
end
