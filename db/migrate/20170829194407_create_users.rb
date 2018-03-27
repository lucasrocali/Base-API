class CreateUsers < ActiveRecord::Migration[5.1]
  def change
    create_table :users do |t|
      t.string :name
      t.string :email
      t.string :password_digest
      t.integer :login_type
      t.string :img_url
      t.string :social_id

      t.timestamps
    end
  end
end
