class Comment < ActiveRecord::Base
  belongs_to :link

  after_save :update_cumulative_score

  def vote_up
  	self.score += 1
  end

  def update_cumulative_score
  	self.link.update_cumulative_score if self.link
  end
end
