# frozen_string_literal: true

class User < ApplicationRecord
  has_secure_password

  has_many :attempts

  PASSWORD_FORMAT = /\A
  (?=.{8,20})        # Must contain 8 or more characters and less than 20
  (?=.*[A-Za-z])     # Must contain a lower or upper case character
  /x.freeze

  validates :password,
            presence: true,
            confirmation: true,
            length: { minimum: 8, maximum: 20, unless: -> { errors[:password].any? } }
  # format: { with: PASSWORD_FORMAT },
  # if: :validate_password?
  #
  # def validate_password?
  #   (password.present? || password_confirmation.present?) || new_record?
  # end

  def remember
    update_attribute(:remember_token, new_token)
  end

  def forget
    update_attribute(:remember_token, nil)
  end

  def new_token
    SecureRandom.urlsafe_base64
  end
end
