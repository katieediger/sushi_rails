class AddSushiRefToData < ActiveRecord::Migration[5.1]
  def change
    add_reference :data, :sushi, foreign_key: true
  end
end
