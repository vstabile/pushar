module Pushar
  class Newsletter < ActiveRecord::Base
    validates :name, presence: true
  end
end