# frozen_string_literal: true

class Answer < ApplicationRecord
  belongs_to :question, counter_cache: true
  belongs_to :variant, optional: true # якщо не встигли відповісти то питання без відповіді (без обраного варіанту)
  belongs_to :attempt

  def correct
    pp variant&.correct
  end

  # belongs_to :user
end
