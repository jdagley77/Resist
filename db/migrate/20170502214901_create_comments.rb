class CreateComments < ActiveRecord::Migration[5.0]
  def change
    create_table :comments do |t|
      t.text        :comment, null: false
      t.references  :user
      t.references  :issue

      t.timestamps
    end
  end
end
