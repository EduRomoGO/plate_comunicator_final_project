class CreateComments < ActiveRecord::Migration
  def change
    create_table :comments do |t|
      t.references :issue, index: true
      t.text :text

      t.timestamps
    end
  end
end
