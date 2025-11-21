class CreateDoctors < ActiveRecord::Migration[7.1]
  def change
    create_table :doctors do |t|
      t.string :name
      t.string :specialization
      t.datetime :available_from
      t.datetime :available_to

      t.timestamps
    end
  end
end
