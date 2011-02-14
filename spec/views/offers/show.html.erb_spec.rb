require 'spec_helper'

describe "offers/show.html.erb" do
  before(:each) do
    @offer = assign(:offer, stub_model(Offer))
  end

  it "renders attributes in <p>" do
    render
  end
end
