class User < ApplicationRecord
  after_destroy :ensure_an_admin_remains
  has_secure_password

  private

  def ensure_an_admin_remains
    if User.count.zero?
      errors.add(:base, "At least one admin user must exist.")
      throw :abort
    end
  end
end
