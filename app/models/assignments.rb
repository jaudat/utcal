class Assignments < ActiveRecord::Base
  attr_accessible :cid, :submit_date
    has_and_belongs_to_many :courses 
end
