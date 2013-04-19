class Assignment < ActiveRecord::Base
  attr_accessible :description, :end, :start, :title, :type
end
