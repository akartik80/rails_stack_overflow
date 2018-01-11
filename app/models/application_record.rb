class ApplicationRecord < ActiveRecord::Base
  include Commentable
  include Revisionable
  include SoftDeletable
  include Votable

  self.abstract_class = true

  alias really_destroy destroy
  alias really_destroy! destroy!

  def destroy
    update_attributes(deleted_at: Time.now)
  end

  def destroy!
    update_attributes!(deleted_at: Time.now)
  end
end
