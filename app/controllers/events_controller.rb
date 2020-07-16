class EventsController < ApplicationController
  before_action :set_event, except: [:create, :index, :active_events]

  def index
    events = if is_admin? 
                    Event.all.order('created_at DESC')
                  else
                    current_user.events.order('created_at DESC')
                  end
    return json_response({ events: events }) unless events.empty?
    json_response({ message: Message.records_not_found('events') })
  end

  def active_events
    events = if is_admin?
                    Event.active_events
                  else
                    current_user.events.active_events
                  end
    return json_response({ events: events }) unless events.empty?
    json_response({ message: Message.records_not_found('active events') })
  end

  def create
    event = current_user.events.create!(event_params)
    json_response({ message: Message.create_success('Event'), data: event }, :created)
  end

  def generate_invitation_url
    url = "#{request.protocol}#{request.host_with_port}/events/#{@event.id}/invitation"
    json_response({ message: Message.create_success('Invitation link'), event_link: url })
  end

  def show
    return json_response({ error: Message.unauthorized }, 403) unless is_mine?(@event) || is_admin?
    return json_response({ event: @event })
  end

  def event_invitation
    return json_response({ message: Message.event_not_active }, :unprocessable_entity)  unless is_active?(@event) || is_mine?(@event) || is_admin?
    json_response({ message: Message.event_invitation, event: @event })
  end

  def update
    return json_response({ error: Message.unauthorized }, 403) unless is_mine?(@event)
    @event.update!(event_params)
    json_response({ message: Message.update_success('Event'), event: @event })
  end

  def destroy
    return json_response({ error: Message.unauthorized }, 403) unless is_mine?(@event) || is_admin?
    @event.destroy
    json_response({ message: Message.delete_success('Event') })
  end

  private

  def event_params
    params.permit(
      :name,
      :description,
      :venue, :start_time,
      :gate_fee,
      :end_time,
      :is_free,
      :is_active
    )
  end

  def set_event
    @event ||= Event.find(params[:id])
  end
end
