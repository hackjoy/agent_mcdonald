### Agent McDonald

Agent McDonald is a simple Reflex Agent with the goal of serving customers as quickly as possible.

In our 2D environment, each cell is represented as an array of values, where each value relates to an attribute in the environment.

Currently only a single value is supported, which represents whether a customer is present or not. 0 meaning no customer is present, 1 meaning there is a customer waiting to be served. An example of a world with size `y: 1, x: 2` is shown below:

```ruby
[
  [ [0], [1] ]
]
```

The Reflex Agent will either serve the customer (if one is present at the agent's current location) or move to another location.

Run the test suite with `bundle exec rspec` which for Test 1 is configured to return an environment with two customers present:

```ruby
[
  [ [1], [1] ]
]
```

It will generate the following `simulation.log` file for the environment above:

```plaintext
D, [2015-05-05T20:10:33.393941 #9171] DEBUG -- : Simulation Test 1 running...
D, [2015-05-05T20:10:33.394047 #9171] DEBUG -- :
        state after 0 moves: [[[1], [1]]]
        agent location: {:x=>0, :y=>0}

D, [2015-05-05T20:10:33.394096 #9171] DEBUG -- :
        state after 1 moves: [[[0], [1]]]
        agent action: served customer
        agent location: {:x=>0, :y=>0}
        customers_waiting: 1

D, [2015-05-05T20:10:33.394134 #9171] DEBUG -- :
        state after 2 moves: [[[0], [1]]]
        agent action: moved right
        agent location: {:x=>1, :y=>0}
        customers_waiting: 1

D, [2015-05-05T20:10:33.394166 #9171] DEBUG -- :
        state after 3 moves: [[[0], [0]]]
        agent action: served customer
        agent location: {:x=>1, :y=>0}
        customers_waiting: 0

D, [2015-05-05T20:10:33.394199 #9171] DEBUG -- :
        average number of customers waiting: 1.0

D, [2015-05-05T20:10:33.394235 #9171] DEBUG -- : Simulation Test 1 ended.
```
