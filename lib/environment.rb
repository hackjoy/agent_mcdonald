require_relative '../config'

# Generates a 2D environment for an agent to explore
class Environment
  attr_accessor :boundary, :customer_placement, :state, :step

  def initialize(boundary: { x: 2, y: 1 }, customer_placement: 'random')
    @boundary = boundary
    @customer_placement = customer_placement
    @state = setup_environment
    @step = 1
  end

  # Generates 2D array. Each cell contains attributes that describe the environment.
  # Each attribute has a range of values noted below as: (attribute = range_of_values)
  # Currently each cell contains:
  #   [ (customer_placement = 0..1) ]
  def setup_environment
    environment = []
    1.upto(boundary[:y]) do |_n|
      row = []
      1.upto(boundary[:x]) do |_n|
        row << [0] # cell values defined
      end
      environment.unshift row # stack the rows
    end
    set_customers(environment)
  end

  # returns a new environment state
  def next_state(environment)
    @step += 1
    environment.state
  end

  # returns a 2D array based on random placement of customers
  def set_customers(current_state)
    if customer_placement == 'random'
      current_state.map do |row|
        row.map do |cell|
          [ Random.rand(2) ]
        end
      end
    end
  end

  # Performance measures

  def measure_performance
    current_number_of_customers_waiting
  end

  def current_number_of_customers_waiting
    number_of_customers_waiting = 0
    state.map do |row|
      row.map do |cell|
        number_of_customers_waiting += 1 if customer_waiting?(cell[0])
      end
    end
    number_of_customers_waiting
  end

  def customer_waiting?(value)
    value == 1
  end
end
