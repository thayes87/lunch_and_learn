class User < ApplicationRecord

  validates :name, presence: true
  validates :email, presence: true, uniqueness: true
  validates :api_key, presence: true, allow_nil: true

  def create_api_key
    update_columns(api_key: SecureRandom.base64)
  end
end