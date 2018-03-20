require 'rails_helper'

RSpec.describe "data/index", type: :view do
  before(:each) do
    assign(:data, [
      Datum.create!(),
      Datum.create!()
    ])
  end

  it "renders a list of data" do
    render
  end
end
