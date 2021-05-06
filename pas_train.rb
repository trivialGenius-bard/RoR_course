# frozen_string_literal: true

require_relative 'train'

# PassengerTrain class
class PassengerTrain < Train
  def go_to_next
    move_by(1, 'pas')
  end

  def go_to_prev
    move_by(-1, 'pas')
  end

  def hook(carriage)
    hook_by(Pass_carriage, carriage)
  end

  def follow_route(route)
    follow_route_type(route, 'pas')
  end
end
