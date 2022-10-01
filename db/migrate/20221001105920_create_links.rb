class CreateLinks < ActiveRecord::Migration[7.0]
  def change
    create_table :links do |t|
      t.string :link
      t.string :title
      t.string :review

      t.timestamps
    end
  end
end
