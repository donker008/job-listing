class CreateCompanies < ActiveRecord::Migration[5.0]
  def change
    create_table :companies do |t|
      t.string :name
      t.string :description
      t.string :brand_icon
      t.string :industry
      t.integer :stars, default: 0;
      t.timestamps
    end
  end
end
