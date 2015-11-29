require 'rails_helper'

RSpec.describe CustomersController, type: :routing do
  it { expect(get:    '/customers').to route_to('customers#index') }
  it { expect(get:    '/customers/1').to route_to('customers#show', id: '1') }
  it { expect(post:   '/customers').to route_to('customers#create') }
  it { expect(put:    '/customers/1').to route_to('customers#update', id: '1') }
  it { expect(delete: '/customers/1').to route_to('customers#destroy', id: '1') }
end
