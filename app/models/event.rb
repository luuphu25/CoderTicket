class Event < ActiveRecord::Base
  belongs_to :venue
  belongs_to :category
  has_many :ticket_types

  validates_presence_of :extended_html_description, :venue, :category, :starts_at
  validates_uniqueness_of :name, uniqueness: {scope: [:venue, :starts_at]}
  validate :check_start_date
  validate :end_date_is_after_start_date
  


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

  private
      def end_date_is_after_start_date
        return if ends_at.blank? || starts_at.blank?

        if ends_at < starts_at
          errors.add(:ends_at, "cannot be before the start date") 
        end 
      end

      def check_start_date
        if starts_at < Time.now
          errors.add(:starts_at, "Start time can't in pass")
        end
      end

end
