require 'spec_helper'

describe "offers/edit.html.erb" do
  before(:each) do
    @offer = assign(:offer, stub_model(Offer))
  end

  it "renders the edit offer form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => offers_path(@offer), :method => "post" do
    end
  end
end
