class Platform < ApplicationRecord
  validates :url, length: { minimum: 6, maximum: 200 }
end
