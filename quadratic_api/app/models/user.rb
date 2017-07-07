class User < ApplicationRecord
  validates :username, presence: true, uniqueness: true, length: { minimum: 3 }
end
