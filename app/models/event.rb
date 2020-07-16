class Event < ApplicationRecord
  before_save :check_is_free

  validates_presence_of :name, :description, :venue, :start_time, :end_time
  validates :gate_fee, numericality: true
  validates :is_free, inclusion: { in: [ true, false ] }
  validates :is_active, inclusion: { in: [ true, false ] }

  belongs_to :user

  def check_is_free
    return if !is_free
    self.gate_fee = 0
  end
end
