class Course < ActiveRecord::Base
  attr_accessible :code, :days, :end, :location, :restrictions, :section, :start
  has_and_belongs_to_many :users
end
