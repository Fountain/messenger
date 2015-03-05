class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :number

      t.timestamps null: false
    end
  end
end
