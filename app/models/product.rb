# frozen_string_literal: true

class Product < ApplicationRecord
  validates :url, presence: true, uniqueness: true
  validates :name, :price, presence: true
end
