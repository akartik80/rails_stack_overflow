class User < ApplicationRecord
  has_many :questions, dependent: destroy
  has_many :answers

  def destroy
  end
end
