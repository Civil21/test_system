# frozen_string_literal: true

class PagesController < ApplicationController
  def index
    @subjects = Subject.limit(3)
  end
end
