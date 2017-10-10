class CreateRunners < ActiveRecord::Migration[5.1]
  def change
    create_table :runners do |t|
      t.string :username
      t.string :password_digest
      t.string :name
      t.date :birthday
      t.string :gender
    end
  end
end
