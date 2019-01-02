class CreateCurrencies < ActiveRecord::Migration[5.2]
  def change
    create_table :currencies do |t|
      t.timestamps
      t.date :date
      t.text :iso_code
      t.float :rate
    end
  end
end
