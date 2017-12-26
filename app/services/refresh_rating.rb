class RefreshRating
  attr_accessor :mechanic

  def initialize(mechanic)
    @mehcanic = mechanic
  end

  def self.call(mechanic)
    new(mechanic).call
  end

  def call
    calculate_rating
  end

  private

  def calculate_rating
    rating = 0.0
    #mechanic = Mechanic.first
    i = 0
    mechanic.comments.each do |comment|
      rating = rating + ((comment.rating_cost + comment.rating_time + comment.rating_general) / 3)
      i = i+1
    end
    mechanic.update_attribute(:rating,(rating / i).round(2))
  end
end
