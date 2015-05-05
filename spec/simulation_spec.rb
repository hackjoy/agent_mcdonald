require_relative './spec_helper.rb'

def log_start_test(simulation, n)
  simulation.simulation_log.debug "Simulation Test #{n} running..."
end

def log_eng_test(simulation, n)
  simulation.simulation_log.debug "Simulation Test #{n} ended."
end

describe Simulation do

  it 'should run the simulation' do
    allow(Random).to receive(:rand).with(2).and_return(1)

    agent = ReflexAgent.new
    environment = Environment.new
    simulation = Simulation.new(agent: agent, environment: environment)
    log_start_test(simulation, 1)

    performance = simulation.run

    expect(performance).to eq 1.0

    log_eng_test(simulation, 1)
  end

end
