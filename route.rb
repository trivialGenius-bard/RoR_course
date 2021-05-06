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