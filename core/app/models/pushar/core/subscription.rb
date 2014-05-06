module Pushar
  module Core
    class Subscription < ActiveRecord::Base
      validates :email, uniqueness: true, email: true
    end
  end
end
