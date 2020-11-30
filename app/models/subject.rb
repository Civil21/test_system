# frozen_string_literal: true

class Subject < ApplicationRecord
  has_many :questions
  has_many :attempts

  validate :present?, :name
  def self.import(sheet)
    header = sheet.row(1)

    # error_images = {}
    (2..sheet.last_row).each do |i|
      row = Hash[[header, sheet.row(i)].transpose]
      subject = Subject.find_or_create_by(name: row['name'].to_s.strip)
      subject.desc = row['desc'].to_s
      subject.questions_size = row['questions_size'].to_i
      subject.time_size = row['time_size'].to_i
      subject.save!
    end
  end
end
