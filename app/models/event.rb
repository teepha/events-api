class Event < ApplicationRecord
  validates_presence_of :name, :description, :venue, :start_time, :end_time, :gate_fee
  validates :is_free, inclusion: { in: [ true, false ] }
  validates :is_active, inclusion: { in: [ true, false ] }

  belongs_to :user
end
