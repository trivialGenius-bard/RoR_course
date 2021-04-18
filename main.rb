class Station
  attr_reader :trains, 
              :name, 
              :fr_num, 
              :pas_num
  def initialize(name)
    @name = name
    @trains = []                #список поездов
    @fr_num = 0
    @pas_num = 0
  end
  #прибытие поездов
  def train_arrival(train)
    @trains << train
    if train.type == "пассажирский"
      @pas_num +=1
    else
      @fr_num += 1
    end
  end
  #отправление поезда
  def train_department(train)
    @trains.delete(train)
    if train.type == "пассажирский"
      @pas_num -= 1
    else
      @fr_num -= 1
    end
  end
end
class Train
  attr_reader :velocity, 
              :num_of_wagons, 
              :st_num, 
              :type, 
              :station,
              :route,
              :next_station,
              :prev_station,
              :number
  def initialize(number, type, wagnum)
    @number = number          #номер
    @type = type
    @num_of_wagons = wagnum     #количество вагонов
    @velocity = 0
    @station = nil
    @route = nil
    @st_num = 0
  end
  #ускорение
  def accelerate(v)
    @velocity += v
  end
  #торможение
  def stop
    @velocity = 0
  end
  #прицепление вагона
  def hook
    if @velocity == 0
      @num_of_wagons += 1
    end
  end
  #отцепление вагона
  def unhook
    if @velocity == 0 && @num_of_wagons > 0
      @num_of_wagons -= 1
    end
  end
  def follow_route(route)
    @route = route
    @station = route.stations[0]
    @st_num = 0
  end
  def go_to_next
    if @st_num == @route.stations.length-1
      #сообщение о попытке выхода за пределы маршрута
      puts "Поезд дальше не идет, просьба выйти из вагона"   
    else
      @st_num +=1
      @station = @route.stations[@st_num]
    end
  end
  def go_to_prev
    if @st_num == 0
      #сообщение о попытке выхода за пределы маршрута
      puts "Поезд дальше не идет, просьба выйти из вагона"
    else
      @st_num -= 1
      @station = @route.stations[@st_num]
    end
  end
end
class Route
  attr_reader :stations
  def initialize(arr, *inter, dep)
    @arr_station = arr
    @dep_station = dep
    @stations = [arr] + inter + [dep]
  end
  def add_inter(station)
    dep = @stations.pop
    @stations<<station
    @stations.push(dep)
  end
  def remove_inter(station)
    @stations.delete(station)
  end
end