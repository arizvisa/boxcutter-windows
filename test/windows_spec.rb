require_relative 'spec_helper'

describe 'windows box' do
  it 'should have a vagrant user' do
    expect(user 'root').to exist
    expect(user 'user').to exist
  end
end
