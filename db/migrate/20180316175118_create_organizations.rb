class CreateOrganizations < ActiveRecord::Migration[5.1]
  def change
    create_table :organizations do |t|
      t.string :name
      t.string :password_digest
      t.string :email

      t.timestamps
    end
  end
end
