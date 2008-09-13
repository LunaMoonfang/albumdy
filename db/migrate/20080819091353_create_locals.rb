class CreateLocations < ActiveRecord::Migration
  def self.up
    create_table :locations do |t|
      t.references :photo, :null => false
      
      t.string :name, :limit => 100

      # PostgreSQL
      t.point :geom, :null => false, :srid => 4326, :with_z => true      
      #MySQL
      #t.column "geom", :point, :srid => 4326
    end
    
    # PostgreSQL
    add_index "locals", "geom", :spatial => true    
    #MySQL
    # dunno, but the above doesn`t work.heh
  end


  def self.down
    drop_table :locations
  end
end
