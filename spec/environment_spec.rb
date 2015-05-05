require_relative './spec_helper.rb'

describe Environment do
  it 'should initialize with a default boundary, customer placement and create the world state' do
    allow(Random).to receive(:rand).with(2).and_return(1)

    env = Environment.new

    expect(env.boundary[:x]).to eq 2
    expect(env.boundary[:y]).to eq 1
    expect(env.customer_placement).to eq 'random'
    expect(env.state).to eq [ [ [1], [1] ] ]
  end
end
