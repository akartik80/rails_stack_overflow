class WrongPasswordError < ActiveRecord::RecordNotFound
  attr_reader :message

  def initialize(message = nil)
    @message = message
    super
  end
end
