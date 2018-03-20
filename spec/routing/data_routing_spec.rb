require "rails_helper"

RSpec.describe DataController, type: :routing do
  describe "routing" do

    it "routes to #index" do
      expect(:get => "/data").to route_to("data#index")
    end

    it "routes to #new" do
      expect(:get => "/data/new").to route_to("data#new")
    end

    it "routes to #show" do
      expect(:get => "/data/1").to route_to("data#show", :id => "1")
    end

    it "routes to #edit" do
      expect(:get => "/data/1/edit").to route_to("data#edit", :id => "1")
    end

    it "routes to #create" do
      expect(:post => "/data").to route_to("data#create")
    end

    it "routes to #update via PUT" do
      expect(:put => "/data/1").to route_to("data#update", :id => "1")
    end

    it "routes to #update via PATCH" do
      expect(:patch => "/data/1").to route_to("data#update", :id => "1")
    end

    it "routes to #destroy" do
      expect(:delete => "/data/1").to route_to("data#destroy", :id => "1")
    end

  end
end
