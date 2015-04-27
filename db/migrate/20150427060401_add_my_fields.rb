class AddMyFields < ActiveRecord::Migration
  def change
    add_column :events, :splash_image_url, :string
    add_column :events, :long_description, :text
  end
end
