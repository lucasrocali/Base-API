class CreateUserWorks < ActiveRecord::Migration[5.1]
  def change
    create_table :user_works, id: :uuid  do |t|
      t.references :user, type: :uuid, foreign_key: true
      t.references :work, type: :uuid, foreign_key: true

      t.timestamps
    end
  end
end
