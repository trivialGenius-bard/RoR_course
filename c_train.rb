# frozen_string_literal: true

require_relative 'train'

# Cargo train class
class CargoTrain < Train
  def go_to_next
    move_by(1, 'car')
  end

  def go_to_prev
    move_by(-1, 'car')
  end

  def hook(carriage)
    hook_by(Cargo_carriage, carriage)
  end

  def follow_route(route)
    follow_route_type(route, 'car')
  end
end
