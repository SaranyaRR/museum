class CreateTickets < ActiveRecord::Migration
  def change
    create_table :tickets do |t|
      t.string :ticket_id
      t.string :entry
      t.string :exit
      t.datetime :in_time
      t.datetime :out_time

      t.timestamps
    end
  end
end
