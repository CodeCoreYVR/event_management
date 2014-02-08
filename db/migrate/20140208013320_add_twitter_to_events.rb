class AddTwitterToEvents < ActiveRecord::Migration
  def change
    add_column :events, :twitter, :string
  end
end
