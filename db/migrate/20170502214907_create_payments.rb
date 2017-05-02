class CreatePayments < ActiveRecord::Migration[5.0]
  def change
    create_table :payments do |t|
      t.decimal     :amt, null: false
      t.string      :status
      t.references  :user
      t.references  :issue

      t.timestamps
    end
  end
end
