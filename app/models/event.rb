class Event < ActiveRecord::Base
  belongs_to :venue
  belongs_to :category
  has_many :ticket_types

  validates_presence_of :extended_html_description, :venue, :category, :starts_at
  validates_uniqueness_of :name, uniqueness: {scope: [:venue, :starts_at]}

  def self.search(search)
    where("name LIKE ?","%#{search}%")
  end

  def self.upcoming
      where("ends_at > ?", Time.now).published
  end

  def self.published
    where.not(published_at: nil)
  end

  def publish
    if have_enough_ticket_type?
      self.update(published_at:Time.now)   
    end
  end

  def have_enough_ticket_type?
    return not(TicketType.where(event_id: self.id).empty?)
  end
end
