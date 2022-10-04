class Link < ApplicationRecord
  acts_as_votable

  youtube_link_format = /(?:https?:\/\/)?(?:www\.)?youtu\.?be(?:\.com)?\/?.*(?:watch|embed)?(?:.*v=|v\/|\/)([\w\-_]+)\&?/

  has_many :comments, as: :commentable, dependent: :destroy

  validates :link, format: { with: youtube_link_format, message: 'should be a valid youtube link' }
  validates :title, presence: true
  validates :review, presence: true
  validate :size_check

  def size_check
    if link.include?('watch?v=')
      @uid = link.split('watch?v=')[1]
      errors.add(:link, 'should be a valid youtube link') if @uid&.size != 11 && !errors.any?

    else
      @uid = link.split('.com/')[1]
      errors.add(:link, 'should be a valid youtube link') if @uid&.size != 11 && !errors.any?
    end
  end

  def embed
    link.insert((link.index('.com/') + 5), 'embed/') unless link.match('embed')
    link.slice! ('watch?v=')
    link
  end
end

