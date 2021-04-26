# frozen_string_literal: true

# Station class
class Station
  attr_reader :trains,
              :name

  def initialize(name)
    @name = name
    @trains = [] # list of trains
  end

  def train_arrival(train)
    @trains << train
  end

  def train_department(train)
    @trains.delete(train)
  end

  def train_by(type)
    @trains.select { |t| t.type == type }
  end

  def count_train_by(type)
    train_by(type).length
  end
end

# Train class
class Train
  attr_reader :velocity,
              :num_of_wagons,
              :st_num,
              :type,
              :route,
              :number

  def initialize(number, type, wagnum)
    @number = number
    @type = type
    @num_of_wagons = wagnum
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

  def hook
    @num_of_wagons += 1 if @velocity.zero?
  end

  def unhook
    @num_of_wagons -= 1 if @velocity.zero? && @num_of_wagons.positive?
  end

  def follow_route(route)
    @route = route
    @route.stations[0].train_arrival self
    @st_num = 0
  end

  def station
    @route.stations[@st_num]
  end

  def move_by(num)
    if (@st_num + num >= @route.stations.length) || (@st_num + num).negative?
      puts 'Поезд дальше не идет, просьба выйти из вагона'
    else
      station.train_department self
      @st_num += num
      station.train_arrival self
    end
  end

  def go_to_next
    move_by(1)
  end

  def go_to_prev
    move_by(-1)
  end

  def next_station
    @route.stations[@st_num + 1]
  end

  def prev_station
    @route.stations[@st_num - 1]
  end
end

# Route class
class Route
  attr_reader :stations

  def initialize(arr, *inter, dep)
    @arr_station = arr
    @dep_station = dep
    @stations = [arr] + inter + [dep]
  end

  def add_inter(station)
    @stations.insert(@stations.length - 1, station)
  end

  def remove_inter(station)
    @stations.delete(station)
  end
end
