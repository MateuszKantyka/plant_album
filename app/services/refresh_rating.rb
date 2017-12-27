class RefreshRating
  attr_accessor :mechanic

  def initialize(mechanic)
    @mechanic = mechanic
  end

  def self.call(mechanic)
    new(mechanic).call
  end

  def call
    set_rating
  end

  private

  def set_rating
    return mechanic.update_attribute(:rating, 0) if mechanic.comments.empty?

    rating = mechanic.comments.map do |comment|
      (comment.rating_cost + comment.rating_time + comment.rating_general) / 3.0
    end

    mechanic.update_attribute(:rating, (rating.sum / rating.length).round(2))
  end
end
