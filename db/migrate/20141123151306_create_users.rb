class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string	:identification_type
      t.string	:identification_number
      t.boolean :extra_plates
      t.string	:plate
      t.timestamps
    end
  end
end