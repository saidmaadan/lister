class CreateCategorizations < ActiveRecord::Migration
  def change
    create_table :categorizations do |t|
      t.references :listing, index: true
      t.references :amenity, index: true

      t.timestamps
    end
  end
end
