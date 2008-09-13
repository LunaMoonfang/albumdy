class Location < ActiveRecord::Base
  belongs_to :photo

  validates_presence_of :geom
  
  
end

# How to create a location geom:
#
# x = Point.new_from_x_y_z(lat, lon, alt)
# Use 0.0 if you dont have altitude.
# @photo.location.geom = x
#

# To get it back:
# @photo.location.geom.x => lat
# @photo.location.geom.y => lon
