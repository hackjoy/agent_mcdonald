# Generates a 2D environment for an agent to explore
class Environment

  attr_reader :boundary, :customer_placement, :state, :step

  def initialize(boundary: {x: 2, y: 1}, customer_placement: 'random')
    @boundary = boundary
    @customer_placement = customer_placement
    @state = create_environment
    @step = 1
  end

  # Generates a 2D array where each cell is reprented by an array
  # containing values which relate to the properties of the environment
  # Currently contains a single binary value representing the presence of a customer
  def create_environment
    environment = []
    boundary[:y].downto(1) do |n|
      row = []
      1.upto(boundary[:x]) do |n|
        # TODO: more values could be added here
        # to represent different env attributes
        row << [ 0 ]
      end
      environment << row
    end
    environment
  end

  # mutate the environment state based on passage of time
  def next_state(environment)
    step += 1
    receive_customers
  end

  # returns a 2D array based on random placement of customers
  def receive_customers
    if customer_placement == 'random'
      state.map do |row|
        row.map do |cell|
          [rand(2)]
        end
      end
    end
  end

  # Performance measure
  def measure_performance
    current_number_of_customers_waiting
  end

  def current_number_of_customers_waiting
    number_of_customers_waiting = 0
    state.map do |row|
      row.map do |cell|
        number_of_customers_waiting += 1 if cell[0] == 1
      end
    end
    number_of_customers_waiting
  end

end

class SimulationRunner

  attr_reader :agent, :environment, :performance_measure

  def initialize(agent:, environment:, performance_measure:)
    @agent = agent
    @environment = environment
    # TODO: Allow switching of performance measures
    @performance_measure = performance_measure
  end

  def run
    performance_measure = 0

    until agent.total_moves > agent.allowed_moves do
      environment.state = agent.action(environment)
      performance_measure += environment.measure_performance
      environment.state = environment.next_state
    end

    (performance_measure / agent.allowed_moves).to_f
  end

end

class AgentReflex

  attr_accessor :total_moves, :allowed_moves

  def initialize(allowed_moves: 10)
    @total_moves = 0
    @allowed_moves = allowed_moves
  end

  def action(environment)
    total_moves += 1
    # returns an environment
  end

end
