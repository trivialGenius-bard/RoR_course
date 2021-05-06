# frozen_string_literal: true

require_relative 'c_train'
require_relative 'car_car'
require_relative 'pas_car'
require_relative 'pas_train'
require_relative 'route'
require_relative 'stantion'

def gets_station_from(list)
  station = gets.chomp
  station_found = list.find { |stat| stat.name == station }
  if station_found.nil?
    puts 'Станция не найдена'
    exit
  else
    station_found
  end
end
stations = []
p_trains = []
c_trains = []
routs = []
loop do
  puts "Действия:\n 1. Станции\n 2. Поезда\n 3. Маршруты\n 4. Завершить\n"
  puts 'Что делаем?'
  action = gets.chomp
  case action
  when '4'
    break
  when '1'
    loop do
      puts "Действия:\n 1. Создать\n 2. Просмотреть список\n 3. Поезда на станции\n 4. Назад\n"
      station_act = gets.chomp
      case station_act
      when '4'
        break
      when '1'
        puts 'Название станции: '
        name = gets.chomp
        new_station = Station.new(name)
        stations.push(new_station)
      when '2'
        stations.each { |st| puts st.name }
      when '3'
        puts 'Введите станцию: '
        station = gets_station_from(stations)
        puts "Грузовые:\n"
        station.c_trains.each { |train| puts train.number }
        puts "Пассажирские:\n"
        station.p_trains.each { |train| puts train.number }
      end
    end
  when '2'
    loop do
      puts "Действия:\n 1. Создать пассажирский\n 2. Создать грузовой\n 3. Просмотреть список\n 4. Прикрепить маршрут\n 5. Прицепить вагон\n 6. Отцепить вагон\n 7. Переместить вперед\n 8. Переместить назад\n 9. Назад\n"
      train_act = gets.chomp
      case train_act
      when '9'
        break
      when '1'
        puts 'Номер поезда:'
        p_trains.push(PassengerTrain.new(gets.chomp))
      when '2'
        puts 'Номер поезда:'
        c_trains.push(Cargo_train.new(gets.chomp))
      when '3'
        puts 'Пассажирские:'
        p_trains.each { |t| puts t.number }
        puts 'Грузовые:'
        c_trains.each { |t| puts t.number }
      when '4'
        puts 'Номер поезда:'
        num = gets.chomp
        puts "Тип поезда:\n 1. Пассажирский\n 2. Грузовой\n"
        type = gets.chomp
        train = nil
        case type
        when '1'
          train = p_trains.find { |t| t.number == num }
        when '2'
          train = c_trains.find { |t| t.number == num }
        end
        puts 'Поезд не найден' if train.nil?
        puts "Маршрут:\n Станция отправления:"
        first_station = gets_station_from(stations)
        puts 'Станция прибытия:'
        term_station = gets_station_from(stations)
        route = routs.find { |rte| rte.stations[0] == first_station && rte.stations[rte.stations.length - 1] == term_station }
        if route.nil?
          puts 'Маршрут не найден'
        else
          train.follow_route(route)
        end
      when '5'
        puts 'Номер поезда: '
        num = gets.chomp
        puts "Тип поезда:\n 1. Пассажирский\n 2. Грузовой\n"
        type = gets.chomp
        train = nil
        case type
        when '1'
          train = p_trains.find { |t| t.number == num }
          new_train = train
          new_train.hook(PassCarriage.new)
          p_trains.map { |trn| trn == train ? trn : new_train }
        when '2'
          train = c_trains.find { |t| t.number == num }
          new_train = train
          new_train.hook(CargoCarriage.new)
          p_trains.map { |trn| trn == train ? trn : new_train }
        end
        puts 'Поезд не найден' if train.nil?
      when '6'
        puts 'Номер поезда: '
        num = gets.chomp
        puts "Тип поезда:\n 1. Пассажирский\n 2. Грузовой\n"
        type = gets.chomp
        train = nil
        case type
        when '1'
          train = p_trains.find { |t| t.number == num }
        when '2'
          train = c_trains.find { |t| t.number == num }
        end
        if train.nil?
          puts 'Поезд не найден'
        else
          new_train = train
          new_train.unhook(new_train.carriage[0])
          if type == '1'
            p_trains.map { |trn| trn == train ? trn : new_train }
          else
            c_trains.map { |trn| trn == train ? trn : new_train }
          end
        end
      when '7'
        puts 'Номер поезда: '
        num = gets.chomp
        puts "Тип поезда:\n 1. Пассажирский\n 2. Грузовой\n"
        type = gets.chomp
        train = nil
        case type
        when '1'
          train = p_trains.find { |t| t.number == num }
        when '2'
          train = c_trains.find { |t| t.number == num }
        end
        if train.nil?
          puts 'Поезд не найден'
        else
          new_train = train
          new_train.go_to_next
          if type == '1'
            p_trains.map { |trn| trn == train ? trn : new_train }
          else
            c_trains.map { |trn| trn == train ? trn : new_train }
          end
        end
      when '8'
        puts 'Номер поезда: '
        num = gets.chomp
        puts "Тип поезда:\n 1. Пассажирский\n 2. Грузовой\n"
        type = gets.chomp
        train = nil
        case type
        when '1'
          train = p_trains.find { |t| t.number == num }
        when '2'
          train = c_trains.find { |t| t.number == num }
        end
        if train.nil?
          puts 'Поезд не найден'
        else
          new_train = train
          new_train.go_to_prev
          if type == '1'
            p_trains.map { |trn| trn == train ? trn : new_train }
          else
            c_trains.map { |trn| trn == train ? trn : new_train }
          end
        end
      end
    end
  when '3'
    loop do
      puts "Действия:\n 1. Создать маршрут\n 2. Добавить промежуточную станцию\n 3. Удалить станцию\n 4. Показать маршрут\n 5. Назад\n"
      route_act = gets.chomp
      case route_act
      when '1'
        puts "Введите маршрут. Чтобы закончить, введите 0\n"
        route = []
        station = gets.chomp
        while station != '0'
          station_found = stations.find { |stat| stat.name == station }
          if station_found.nil?
            puts 'Станция не найдена'
          else
            route.push(station_found)
          end
          station = gets.chomp
        end
        routs.push(Route.new(route[0], route[1..route.length - 2], route[route.length - 1]))
      when '2'
        puts "Маршрут:\n Станция отправления:"
        first_station = gets_station_from(stations)
        puts 'Станция прибытия:'
        term_station = gets_station_from(stations)
        route = routs.find { |rte| rte.stations[0] == first_station && rte.stations[rte.stations.length - 1] == term_station }
        if route.nil?
          puts 'Маршрут не найден'
        else
          puts 'Введите станцию: '
          station_found = gets_station_from(stations)
          new_route = route
          new_route.add_inter(station_found)
          routs.map { |rte| rte == route ? rte : new_route }
        end
      when '3'
        puts "Маршрут:\n Станция отправления:"
        first_station = gets_station_from(stations)
        puts 'Станция прибытия:'
        term_station = gets_station_from(stations)
        route = routs.find { |rte| rte.stations[0] == first_station && rte.stations[rte.stations.length - 1] == term_station }
        if route.nil?
          puts 'Маршрут не найден'
        else
          puts 'Введите станцию: '
          station_found = gets_station_from(stations)
          unless (route.stations.find { |stat| stat == station_found }).nil?
            new_route = route
            new_route.remove_inter(station_found)
            routs.map { |rte| rte == route ? rte : new_route }
          end
        end
      when '4'
        puts "Маршрут:\n Станция отправления:"
        first_station = gets_station_from(stations)
        puts 'Станция прибытия:'
        term_station = gets_station_from(stations)
        route = routs.find do |rte|
          rte.stations[0] == first_station &&
            rte.stations[rte.stations.length - 1] == term_station
        end
        if route.nil?
          puts 'Маршрут не найден'
        else
          route.stations.each { |stat| puts stat }
        end
      when '5'
        break
      end
    end
  end
end
