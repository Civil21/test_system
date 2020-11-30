# frozen_string_literal: true

class SubjectsController < ApplicationController
  def show
    subject
  end

  def index
    @subjects = Subject.all
  end

  private

  def subject
    @subject ||= Subject.find(params[:id])
  end
end
