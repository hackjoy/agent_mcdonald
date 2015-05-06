require_relative '../config'

class ReflexAgent
  attr_accessor :allowed_moves, :location, :total_moves, :previous_action

  def initialize(allowed_moves: 2, location: { x: 0, y: 0 })
    @total_moves = 0
    @allowed_moves = allowed_moves
    @location = { x: 0, y: 0 }
    @previous_action = nil
  end

  # returns a new environment state
  def action(environment)
    @total_moves += 1
    current_cell = environment.state[location[:y]][location[:x]]

    case current_cell[0] # customer_waiting
    when 0
      @previous_action = 'moved right' and return move_right(environment) if can_move_right?(environment)
      @previous_action = 'moved left' and return move_left(environment) if can_move_left?(environment)
    when 1
      @previous_action = 'served customer'
      serve_customer(environment)
    end
  end

  def has_customer?(value)
    value == 1
  end

  def can_move_right?(environment)
    !environment.state[location[:y]][location[:x] + 1].nil?
  end

  def can_move_left?(environment)
    !environment.state[location[:y]][location[:x] - 1].nil?
  end

  def can_move_up?(environment)
    !environment.state[location[:y] - 1][location[:x]].nil?
  end

  def can_move_down?(environment)
    !environment.state[location[:y] + 1][location[:x]].nil?
  end

  #
  # Agent Actions
  #   Actions can be called even if cannot be carried out to support randomized agent.
  #

  # returns environment state where customer has been served in agents current location
  # TODO: this should return a new env state rather than mutating the current one
  def serve_customer(environment)
    environment.state[location[:y]][location[:x]][0] = 0
    environment.state
  end

  # returns the current environment state
  def move_left(environment)
    location[:x] -= 1 if can_move_right?(environment)
    environment.state
  end

  # returns the current environment state
  def move_right(environment)
    location[:x] += 1 if can_move_left?(environment)
    environment.state
  end

  # returns the current environment state
  def move_up(environment)
    location[:y] -= 1 if can_move_up?(environment)
    environment.state
  end

  # returns the current environment state
  def move_down(environment)
    location[:y] += 1 if can_move_down?(environment)
    environment.state
  end
end
