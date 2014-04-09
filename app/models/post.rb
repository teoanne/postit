class Post < ActiveRecord::Base
  include Voteable 
  include Sluggable

  belongs_to :user
  has_many :comments, dependent: :destroy
  has_many :post_categories
  has_many :categories, through: :post_categories

  validates :title, presence: true, length: {minimum: 5}
  validates :url, presence: true, uniqueness: true 
  validates :description, presence: true

  sluggable_column :title

=begin

  # Comparison code
  after_validation :generate_slug # this will generate the slug after validations are run on the title input by the user but before it is saved to the database
  
  def generate_slug
    self.slug = self.title.gsub(" ", "-").downcase
  end

  def to_param
    self.slug
  end
=end

end