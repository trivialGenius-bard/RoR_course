class Station
  attr_reader :trains, :name, :freight_trains, :passenger_trains, :fr_num, :pas_num
  def initialize(name)
    @name = name
    @trains = []                #список поездов
    @freight_trains = []        #список грузовых поездов
    @passenger_trains = []      #список пассажирских поездов
    @fr_num = 0
    @pas_num = 0
  end
  #прибытие поездов
  def train_arrival(train)
    @trains << train
    if train.type == "пассажирский"
      @passenger_trains << train
      @pas_num +=1
    else
      @freight_trains << train
      @fr_num += 1
    end
  end
  #отправление поезда
  def train_department(train)
    @trains.delete(train)
    if train.type == "пассажирский"
      @passenger_trains.delete(train)
      @pas_num -= 1
    else
      @freight_trains.delete(train)
      @fr_num -= 1
    end
  end
end
class Train
  attr_reader :velocity, :num_of_wagons, :next_station, :prev_station, :type, :station, :number
  def initialize(number, type, wagnum)
    @number = number          #номер
    if (type == "пассажирский") || (type == "грузовой") #тип
      @type = type
    else
      #сообщение о неверном типе. По умолчанию присваивается грузовой
      puts "Поезд может быть только пассажирским или грузовым"  
      @type = "грузовой"
    end
    @num_of_wagons = wagnum     #количество вагонов
    @velocity = 0
    nul_st = Station.new("Нет станции")
    @station = nul_st
    @next_station = nul_st
    @prev_station = nul_st
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
    if (@velocity == 0)&&(@num_of_wagons > 0)
      @num_of_wagons -= 1
    end
  end
  def follow_route(route)
    @route = route
    @station = route.stations[0]
    @next_station = route.stations[1]
    @st_num = 0
  end
  def go_to_next
    if @route != nil
      if @st_num == @route.stations.length-1
        #сообщение о попытке выхода за пределы маршрута
        puts "Поезд дальше не идет, просьба выйти из вагона"
      else
        @prev_station = @station
        @station = @next_station
        @st_num +=1
        if @st_num == @route.stations.length-1
          @next_station = Station.new("No Station")
        else
          @next_station = @route.stations[@st_num+1]
        end
      end
    else
      #сообщение об отсутствии маршрута
      puts "Поезд не встал на маршрут"
    end
  end
  def go_to_prev
    if @route != nil
      if @st_num == 0
        #сообщение о попытке выхода за пределы маршрута
        puts "Поезд дальше не идет, просьба выйти из вагона"
      else
        @next_station = @station
        @station = @prev_station
        @st_num -= 1
        if @st_num == 0
          @prev_station = Station.new("Нет станции")
        else
          @prev_station = @route.stations[@st_num-1]
        end
      end
    else
      puts "Поезд не встал на маршрут"
    end
  end

end
class Route
  attr_reader :stations
  def initialize(arr, *inter, dep)
    @arr_station = arr
    @dep_station = dep
    @inter_stations = inter
    @stations = [arr] + inter + [dep]
  end
  def add_inter(station)
    @inter_stations<<station
    @stations = [@arr_station] + @inter_stations + [@dep_station]
  end
  def remove_inter(station)
    @inter_stations.delete(station)
    @stations = [arr] + inter + [dep]
  end
end