require_relative '../environment'

describe Environment do
  it 'should initialize with a default boundary, customer placement and create the world state' do
    env = Environment.new
    expect(env.boundary[:x]).to eq 2
    expect(env.boundary[:y]).to eq 1
    expect(env.customer_placement).to eq 'random'
    expect(env.state).to eq [ [ [0], [0] ] ]
  end
end
