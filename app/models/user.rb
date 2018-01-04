class User < ApplicationRecord
  has_many :questions, dependent: destroy


  def destroy
  end
end
