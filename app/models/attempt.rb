# frozen_string_literal: true

class Attempt < ApplicationRecord
  belongs_to :subject
  belongs_to :user

  has_many :answers
  has_many :questions, through: :answers

  # якщо статус змінився на завершено то підрахувати бали

  enum status: %w[news work complete cancel]

  def time_left
    Time.now < finish_at
  end
end
