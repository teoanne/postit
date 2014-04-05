module Voteable
  extend ActiveSupport::Concern

  included do
    has_many :votes, as: :voteable # this will fire upon Post or Comment class loading
  end

  def total_votes
    self.up_votes - self.down_votes
  end

  def up_votes
    self.votes.where(vote: true).size
  end

  def down_votes
    self.votes.where(vote: false).size
  end

end