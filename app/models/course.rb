class Course < ActiveRecord::Base
  attr_accessible :code, :days, :end, :location, :restrictions, :section, :start
end
