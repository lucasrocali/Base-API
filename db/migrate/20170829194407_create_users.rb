class CreateUsers < ActiveRecord::Migration[5.1]
  def change
    create_table :users do |t|
      t.string :name
      t.string :name
      t.string :email
      t.string :password_digest
      t.integer :login_type

      t.timestamps
    end
  end
end
