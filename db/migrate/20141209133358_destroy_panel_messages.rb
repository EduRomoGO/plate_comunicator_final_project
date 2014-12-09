class DestroyPanelMessages < ActiveRecord::Migration
  def up
  	drop_table :panel_messages
  end
  def down
  end
end
