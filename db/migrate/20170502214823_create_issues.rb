class CreateIssues < ActiveRecord::Migration[5.0]
  def change
    create_table :issues do |t|
      t.string     :title, null: false
      t.text       :description, null: false
      t.references :user

      t.timestamps
    end
  end
end
