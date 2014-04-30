module Pushar
  module Core
    class Subscription < ActiveRecord::Base
      validates :email, presence: true
      validates_uniqueness_of :email
    end
  end
end
