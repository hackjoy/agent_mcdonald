require_relative '../config'

# TODO: Create subclass for the randomized reflex agent, hook #run method

class ReflexAgent
  attr_accessor :allowed_moves, :location, :total_moves, :previous_action, :randomized_actions, :actions

  def initialize(allowed_moves: 2, location: { x: 0, y: 0 }, randomized_actions: false)
    @total_moves = 0
    @allowed_moves = allowed_moves
    @location = { x: 0, y: 0 }
    @randomized_actions = randomized_actions
    @actions = ['move_up', 'move_right', 'move_left', 'move_down']
    @previous_action = nil # used for logging purposes, has no relevance on reflex action chosen
  end

  # returns a new environment state
  def action(environment)
    @total_moves += 1
    current_cell = environment.state[location[:y]][location[:x]]

    if randomized_actions
      self.send(actions.sample, environment)
    else
      case current_cell[0] # customer_waiting
      when 0
        # Reflex Agent is limited - it will move right to left
        # without some randomization or state to tell it to explore up/down
        return move_right(environment) if can_move_right?(environment)
        return move_left(environment) if can_move_left?(environment)
        return move_up(environment) if can_move_up?(environment)
        return move_down(environment) if can_move_down?(environment)
      when 1
        serve_customer(environment)
      end
    end
  end

  def has_customer?(value)
    value == 1
  end

  def can_move_right?(environment)
    environment.state[location[:y]] &&
    !environment.state[location[:y]][location[:x] + 1].nil?
  end

  def can_move_left?(environment)
    environment.state[location[:y]] &&
    !environment.state[location[:y]][location[:x] - 1].nil?
  end

  def can_move_up?(environment)
    environment.state[location[:y] - 1] &&
    !environment.state[location[:y] - 1][location[:x]].nil?
  end

  def can_move_down?(environment)
    environment.state[location[:y] + 1] &&
    !environment.state[location[:y] + 1][location[:x]].nil?
  end

  #
  # Agent Actions
  #   Actions can be called even if cannot be carried out to support randomized agent.
  #

  # returns environment state where customer has been served in agents current location
  # TODO: this should return a new env state rather than mutating the current one
  def serve_customer(environment)
    @previous_action = 'served customer'
    environment.state[location[:y]][location[:x]][0] = 0
    environment.state
  end

  # returns the current environment state
  def move_left(environment)
    @previous_action = 'moved left'
    location[:x] -= 1 if can_move_right?(environment)

    environment.state
  end

  # returns the current environment state
  def move_right(environment)
    @previous_action = 'moved right'
    location[:x] += 1 if can_move_left?(environment)
    environment.state
  end

  # returns the current environment state
  def move_up(environment)
    @previous_action = 'moved up'
    location[:y] -= 1 if can_move_up?(environment)
    environment.state
  end

  # returns the current environment state
  def move_down(environment)
    @previous_action = 'moved down'
    location[:y] += 1 if can_move_down?(environment)
    environment.state
  end
end
