# frozen_string_literal: true

class Attempt < ApplicationRecord
  belongs_to :subject
  belongs_to :user

  before_update :calculate_point

  has_many :answers
  has_many :questions, through: :answers

  # якщо статус змінився на завершено то підрахувати бали

  enum status: %w[news work complete cancel]

  def time_left
    Time.now < finish_at
  end

  private

  def calculate_point
    pp status_change
    if status_changed? && status_change[1] == 'complete'
      self.point = answers.includes(:variant).map { |x| x.variant&.correct ? 1 : 0 }.sum
    end
  end
end
