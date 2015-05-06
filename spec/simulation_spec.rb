require_relative './spec_helper.rb'

def log_start_test(simulation, n)
  simulation.simulation_log.debug "Simulation Test #{n} running..."
end

def log_eng_test(simulation, n)
  simulation.simulation_log.debug "Simulation Test #{n} ended."
end

describe Simulation do

  describe "environment with size x: 2, y: 1" do
    describe 'when there is a customer in each location' do
      it 'should serve all customers when starting from position x: 0' do
        allow(Random).to receive(:rand).with(2).and_return(1)

        agent = ReflexAgent.new(location: { x: 0, y: 0 })
        environment = Environment.new
        simulation = Simulation.new(agent: agent, environment: environment)
        log_start_test(simulation, 1)

        performance = simulation.run

        expect(performance).to eq 1.0

        log_eng_test(simulation, 2)
      end

      it 'should serve all customers when starting from position x: 1' do
        allow(Random).to receive(:rand).with(2).and_return(1)

        agent = ReflexAgent.new(location: { x: 1, y: 0 })
        environment = Environment.new
        simulation = Simulation.new(agent: agent, environment: environment)
        log_start_test(simulation, 1)

        performance = simulation.run

        expect(performance).to eq 1.0

        log_eng_test(simulation, 2)
      end
    end

    describe 'when there are no customers in either location' do
      it 'should serve all customers when starting from position x: 0' do
        allow(Random).to receive(:rand).with(2).and_return(0)

        agent = ReflexAgent.new(location: { x: 0, y: 0 })
        environment = Environment.new
        simulation = Simulation.new(agent: agent, environment: environment)
        log_start_test(simulation, 3)

        performance = simulation.run

        expect(agent).not_to receive(:serve_customer)
        expect(performance).to eq 0.0

        log_eng_test(simulation, 3)
      end
    end
  end
end
