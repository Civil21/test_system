# frozen_string_literal: true

class PagesController < ApplicationController
  before_action :authenticate_user!
  def index
    @subjects = Subject.limit(3)
  end
end
