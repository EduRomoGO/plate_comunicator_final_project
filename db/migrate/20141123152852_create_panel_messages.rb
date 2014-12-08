class CreatePanelMessages < ActiveRecord::Migration
  def change
    create_table :panel_messages do |t|
   	  t.integer :user_id
   	  t.text :text
      t.timestamps
    end
  end
end
