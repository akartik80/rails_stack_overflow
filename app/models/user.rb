class User < ApplicationRecord
  has_many :questions, dependent: delete_user_actions
  has_many :answers, dependent: delete_user_actions
  has_many :comments, dependent: delete_user_actions
  has_many :votes, dependent: delete_user_actions
  has_many :sessions, dependent: invalidate_session

  def delete_user_actions
  end

  def invalidate_session
  end
end
