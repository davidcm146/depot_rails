class User < ApplicationRecord
  has_secure_password
  after_destroy :ensure_an_admin_remains

  private

  def ensure_an_admin_remains
    if User.count.zero?
      errors.add(:base, "At least one admin user must exist.")
      throw :abort
    end
  end
end
