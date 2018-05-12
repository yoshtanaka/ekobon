class Post < ApplicationRecord
  validates :user_id, {presence: true}
  validates :contents, {presence: true}

  def user
    return User.find_by(id: self.user_id)
  end

  def update_time
    return Post.find_by(id: self.id).updated_at.strftime("%Y年%m月%d日 %H時%M分")
  end
end
