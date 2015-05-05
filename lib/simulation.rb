require_relative '../config'

class Simulation
  attr_accessor :agent, :environment, :simulation_log

  def initialize(agent:, environment:)
    @agent = agent
    @environment = environment
    @simulation_log = Logger.new("simulation.log")
  end

  # Allows the agent to act on the environment until exhausted allowed moves
  # returns the performance score
  # Note that methods starting with log_* do not affect the running of the program
  # and simply log output to simulation.log
  def run
    log_starting_state
    performance_measure = 0.0

    until agent.total_moves > agent.allowed_moves
      environment.state = agent.action(environment)
      performance_measure += environment.measure_performance
      environment.state = environment.next_state(environment)
      log_post_step_state
    end

    log_performance(performance_measure)
    (performance_measure.to_f / agent.allowed_moves)
  end

  private
    # Logging methods

    def log_starting_state
      simulation_log.debug {"
        state after 0 moves: #{environment.state}
        agent location: #{agent.location}
      "}
    end

    def log_post_step_state
      simulation_log.debug {"
        state after #{agent.total_moves} moves: #{environment.state}
        agent action: #{agent.previous_action}
        agent location: #{agent.location}
        customers_waiting: #{environment.measure_performance}
      "}
    end

    def log_performance(performance_measure)
      simulation_log.debug {"
        average number of customers waiting: #{(performance_measure / agent.allowed_moves).to_f}
      "}
    end


end
