# frozen_string_literal: true

class Variant < ApplicationRecord
  belongs_to :question
  has_many :answers
end
