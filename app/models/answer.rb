# frozen_string_literal: true

class Answer < ApplicationRecord
  belongs_to :question
  belongs_to :variant, optional: true # якщо не встигли відповісти то питання без відповіді (без обраного варіанту)
  belongs_to :attempt

  # belongs_to :user
end
