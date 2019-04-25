class User < ApplicationRecord
  has_many :dogs, dependent: :destroy
  has_many :appointments, dependent: :destroy
end
