class AddLinkedinToEvents < ActiveRecord::Migration
  def change
    add_column :events, :linkedin, :string
  end
end
