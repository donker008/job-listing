class CreateCompanies < ActiveRecord::Migration[5.0]
  def change
    create_table :companies do |t|
      t.string :name
      t.string :description
      t.string :brand_icon
      t.string :industry
      t.float :stars
      t.timestamps
    end
  end
end
