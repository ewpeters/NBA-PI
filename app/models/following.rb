class Following < ActiveRecord::Base
  belongs_to :woman
  belongs_to :player
end
