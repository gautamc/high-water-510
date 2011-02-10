require File.dirname(__FILE__) + '/../spec_helper'

describe User do 
  it { should embed_one :profile }
end
