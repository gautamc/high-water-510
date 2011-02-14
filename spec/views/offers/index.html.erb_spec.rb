require 'spec_helper'

describe "offers/index.html.erb" do
  before(:each) do
    assign(:offers, [
      stub_model(Offer),
      stub_model(Offer)
    ])
  end

  it "renders a list of offers" do
    render
  end
end
