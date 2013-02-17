class Professor < ActiveRecord::Base
  attr_accessible :email, :f_name, :l_name, :password
end
