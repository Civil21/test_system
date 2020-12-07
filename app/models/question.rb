# frozen_string_literal: true

class Question < ApplicationRecord
  belongs_to :subject
  has_many :variants
  has_many :answers

  enum recomend: %w[непровірене складне звичайне просте]

  def count_correct
    self.correct_answers = answers.includes(:variant).map { |x| x.variant&.correct ? 1 : 0 }.sum
    self.recomend = if correct_answers < answers.size * 0.35
                      1
                    elsif correct_answers < answers.size * 0.65
                      2
                    else
                      3
                    end
    save
  end

  def self.import(file)
    spreadsheet = open_spreadsheet(file)
    Subject.import(spreadsheet.sheet('subjects'))

    sheet = spreadsheet.sheet('questions')
    header = sheet.row(1)

    (2..sheet.last_row).each do |i|
      row = Hash[[header, sheet.row(i)].transpose]
      subject = Subject.find_or_create_by(name: row['subject'].to_s.strip)
      question = find_or_create_by(name: row['question'].to_s.strip)
      question.subject = subject

      question.save!
      question.variants.destroy_all if question.variants.present?
      row['variants'].split(';').each do |variant|
        Variant.find_or_create_by(name: variant.to_s.strip, question: question)
      end
      row['correct_variant'].to_s.split(';').each do |variant|
        variant = Variant.find_or_create_by(name: variant.to_s.strip, question: question)
        variant.correct = true
        variant.save
      end
    end
  end

  def self.open_spreadsheet(file)
    case File.extname(file.original_filename)
    when '.csv' then Roo::Csv.new(file.path)
    when '.xls' then Roo::Excel.new(file.path)
    when '.xlsx' then Roo::Excelx.new(file.path)
    else raise "Unknown file type: #{file.original_filename}"
    end
  end
end
