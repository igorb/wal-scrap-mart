# frozen_string_literal: true

class Product < ApplicationRecord
  has_many :reviews

  validates :url, presence: true, uniqueness: true
  validates :name, :price, presence: true
end
