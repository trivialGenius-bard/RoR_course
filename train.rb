# frozen_string_literal: true

# Train class
class Train
  attr_reader :velocity,
              :st_num,
              :route,
              :carriage,
              :number

  def initialize(number)
    @number = number
    @velocity = 0
    @route = nil
    @st_num = 0
  end

  def accelerate_by(velocity)
    @velocity += velocity
  end

  def stop
    @velocity = 0
  end

  def unhook(carriage)
    @carriage.delete(carriage)
  end

  def station
    @route.stations[@st_num]
  end

  def next_station
    @route.stations[@st_num + 1]
  end

  def prev_station
    @route.stations[@st_num - 1]
  end

  protected

  # вспомогательный метод, используемый в дочерних типах
  def hook_by(type, carriage)
    @carriage.push(carriage) if carriage.instance_of?(type)
  end
end

# мы не хотим, чтобы пользователь мог двигать поезда, как ему заблагорассудится, и используем его в дочерних типах
def move_by(num, type)
  if (@st_num + num >= @route.stations.length) || (@st_num + num).negative?
    puts 'Поезд дальше не идет, просьба выйти из вагона'
  elsif type == 'car'
    station.cargo_train_department self
    @st_num += num
    station.cargo_train_arrival self
  else
    station.pass_train_department self
    @st_num += num
    station.pass_train_arrival self
  end
end

# вспомогательный метод, используемый в дочерних типах
def follow_route_type(route, type)
  @route = route
  if type == 'car'
    @route.stations[0].cargo_train_arrival self
  else
    @route.stations[0].pass_train_arrival self
  end
  @st_num = 0
end
