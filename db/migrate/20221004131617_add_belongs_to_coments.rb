class AddBelongsToComents < ActiveRecord::Migration[7.0]
  def change
    add_reference :comments, :user, index: true
    add_foreign_key :comments, :users
  end
end
