require File.dirname(__FILE__) + '/../spec_helper'

describe Address do
  it { should be_embedded_in(:profile).as_inverse_of(:address) }
end

