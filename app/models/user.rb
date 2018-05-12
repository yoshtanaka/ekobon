class User < ApplicationRecord
  has_secure_password
  validates :name, {presence: true}
  validates :email, {presence: true, uniqueness: true}
  validates :password_digest, {presence: true}

  def latest_post
    return Post.where(user_id: self.id).order('id DESC').first
  end

end
