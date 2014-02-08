class CreateEvents < ActiveRecord::Migration
  def change
    create_table :events do |t|
      t.attachment :photo
      t.string :title
      t.datetime :date
      t.text :body
      t.string :speaker
      t.text :bio

      t.timestamps
    end
  end
end
