# frozen_string_literal: true

class Attempt < ApplicationRecord
  belongs_to :subject
  belongs_to :user

  has_many :answers
  has_many :questions, through: :answers
end
