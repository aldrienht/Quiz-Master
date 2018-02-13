class CreateUsers < ActiveRecord::Migration[5.1]
  def up
    create_table :users do |t|
      t.string :fullname
      t.string :username
      t.string :email
      t.string :password_digest
      t.string :role, default: 'student'
      t.boolean :activated, default: true

      t.timestamps
    end
  end

  def down
    drop_table :users
  end
end
