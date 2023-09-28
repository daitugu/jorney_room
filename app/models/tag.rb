class Tag < ApplicationRecord
  has_many :tagmaps, dependent: :destroy
end
