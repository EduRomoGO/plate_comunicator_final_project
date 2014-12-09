require_relative '../spec_helper'
require_relative '../rails_helper'

describe "user issues page", :type => :feature do

  it "shows the page" do
    visit '/usser/1/issues'
  end

end
