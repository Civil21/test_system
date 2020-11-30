# frozen_string_literal: true

class Session < ApplicationRecord
  belongs_to :user

  before_create :generate_token
  before_create :remove_expired_sessions

  def generate_token
    self.token = encrypt
  end

  def self.destroy_expired
    # where('created_at < ?', Time.now - 12.hours).first&.destroy
  end

  private

  def encrypt
    secure_hash("#{Time.now.utc - rand(1000).hours}--#{user.email}")
  end

  def secure_hash(string)
    Digest::SHA2.hexdigest(string)
  end

  def remove_expired_sessions
    Session.destroy_expired
  end
end
