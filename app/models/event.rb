class Event < ApplicationRecord
  before_save :check_is_free, :if => :is_free

  validates_presence_of :name, :description, :venue, :start_time, :end_time
  validates :gate_fee, numericality: true
  validates :is_free, inclusion: { in: [ true, false ] }
  validates :is_active, inclusion: { in: [ true, false ] }

  scope :active_events, -> { where(is_active: true).order('created_at DESC') }

  belongs_to :user

  validate do
    begin
      if start_time.to_date.past? || end_time.to_date.past?
        errors.add(:time, "Date/time should not be in the past")
      elsif start_time > end_time
        errors.add(:time, "Start date/time should be less than End date/time")
      end
    rescue StandardError => e
      self.errors.add(:time, e.message)
    end
  end

  def check_is_free
    self.gate_fee = 0
  end
end
