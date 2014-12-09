class CreateIssues < ActiveRecord::Migration
  def change
    create_table :issues do |t|
      t.references :user, index: true
      t.text :text

      t.references :target_user, index: true

      t.timestamps
    end
  end
end
