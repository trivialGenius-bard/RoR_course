# frozen_string_literal: true

# Station class
class Station
  attr_reader :c_trains,
              :p_trains,
              :name

  def initialize(name)
    @name = name
    @c_trains = [] # list of trains
    @p_trains = []
  end

  def cargo_train_arrival(train)
    @c_trains << train
  end

  def pass_train_arrival(train)
    @p_trains << train
  end

  def cargo_train_department(train)
    @c_trains.delete(train)
  end

  def pass_train_department(train)
    @p_trains.delete(train)
  end
end
