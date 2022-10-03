class Link < ApplicationRecord
  youtube_link_format = /(?:https?:\/\/)?(?:www\.)?youtu\.?be(?:\.com)?\/?.*(?:watch|embed)?(?:.*v=|v\/|\/)([\w\-_]+)\&?/

  has_many :comments, as: :commentable, dependent: :destroy

  validates :link, presence: true, format: { with: youtube_link_format, message: 'should be a valid youtube link' }
  validates :title, presence: true
  validates :review, presence: true

  def embed
    link.insert((link.index('.com/')+5), 'embed/') unless link.match('embed')
    link.slice! ('watch?v=')
    link
  end
end

