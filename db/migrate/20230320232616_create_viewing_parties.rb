class CreateViewingParties < ActiveRecord::Migration[5.2]
  def change
    create_table :viewing_parties do |t|
      t.string :duration
      t.date :party_date
      t.time :party_time
      t.integer :movie_id
      t.integer :host_id

      t.timestamps
    end
  end
end
