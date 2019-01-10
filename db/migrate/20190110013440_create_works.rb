class CreateWorks < ActiveRecord::Migration[5.1]
  def change
    create_table :works, id: :uuid  do |t|
      t.string :name
      t.integer :order

      t.timestamps
    end
  end
end
