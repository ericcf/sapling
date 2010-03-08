require 'content/base'

class Event < ActiveRecord::Base

  include Content::Base

  has_event_calendar

  validates_presence_of :start_at
  validates_presence_of :end_at
  validate :start_gte_end?,
    :if => Proc.new { |e| !e.start_at.blank? and !e.end_at.blank? }

  define_schema do |s|
    s.string :title, :label => 'Title', :required => true, :display => 'header'
    s.date   :start_at, :label => 'Start Date', :required => true
    s.date   :end_at, :label => 'End Date', :required => true
    s.text   :text, :label => 'Description'
  end

  private

  def start_gte_end?
    unless end_at >= start_at
      errors.add(:end_at, 'must occur after the start')
    end
  end
end