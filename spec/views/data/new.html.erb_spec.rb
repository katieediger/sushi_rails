require 'rails_helper'

RSpec.describe "data/new", type: :view do
  before(:each) do
    assign(:datum, Datum.new())
  end

  it "renders new datum form" do
    render

    assert_select "form[action=?][method=?]", data_path, "post" do
    end
  end
end
