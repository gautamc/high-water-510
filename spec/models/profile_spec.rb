require File.dirname(__FILE__) + '/../spec_helper'

describe Profile do
  it { should be_embedded_in(:user).as_inverse_of(:profile) }
  it { should embed_one(:address) }
end

