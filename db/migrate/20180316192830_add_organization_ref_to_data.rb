class AddOrganizationRefToData < ActiveRecord::Migration[5.1]
  def change
    add_reference :data, :organization, foreign_key: true
  end
end
