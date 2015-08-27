require "rails_helper"

RSpec.describe CartItem, type: :model do
  let!(:project) { Fabricate(:project) }

  before(:each) do
    @cart_item = CartItem.new(project)
  end

  it "returns the title of the item" do
    expect(@cart_item.name).to eq("Sample Project")
  end

  it "returns the description of the item" do
    expect(@cart_item.description).to eq("To make the sample world a better place.")
  end

  it "returns the image url" do
    expect(@cart_item.image).to eq("hello.lpg")
  end

  it "returns the current funding" do
    expect(@cart_item.current_funding).to eq(200)
  end

  it "returns the funding goal" do
    expect(@cart_item.funding_goal).to eq(500)
  end

  it "has an end date" do
    expect(@cart_item.end_date).to eq("2015-12-12")
  end

  it "funding amount defaults to 0" do
    expect(@cart_item.funding_amount).to eq 0
  end
end
