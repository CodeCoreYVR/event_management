class CreateAttendees < ActiveRecord::Migration
  def change
    create_table :attendees do |t|
      t.string :email
      t.string :name
      t.string :company
      t.string :email_token
      t.datetime :confirm_at
      t.boolean :mail_list

      t.timestamps
    end
  end
end
