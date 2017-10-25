class Item < ApplicationRecord
  belongs_to :user

  def completed?
    # Item is completed if `completed_at` is NOT blank!
    # Meaning if it's not null (nil)
    !completed_at.blank?
  end
end
