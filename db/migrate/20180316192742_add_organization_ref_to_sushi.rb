class AddOrganizationRefToSushi < ActiveRecord::Migration[5.1]
  def change
    add_reference :sushis, :organization, foreign_key: true
  end
end
