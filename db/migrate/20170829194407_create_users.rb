class CreateUsers < ActiveRecord::Migration[5.1]
  def change
    create_table :users, id: :uuid  do |t|
      t.string :name
      t.string :email
      t.string :password_digest
      t.integer :login_type
      t.string :img_url
      t.string :social_id
      t.string :descp
      t.string :school

      t.timestamps
    end
  end
end
