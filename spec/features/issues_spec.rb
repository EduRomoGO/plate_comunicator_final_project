require_relative '../rails_helper'

describe "user issues page", :type => :feature do

  it "shows the page" do
    visit '/users/1/issues'
  end

  xit "capybara test" do
    visit '/users/1/issues'
    page.should have_xpath('//p')
    expect(all('p').count).to be(1)
  end

  it "shows the issues list where user is owner" do
    u = User.create(:identification_type => 'nif',
    					:identification_number => '12345678A',
    					:plate => '1234AAA', 
    					:extra_plates => 'false')

    Issue.create(:user_id => u.id,
							 :text => 'park issue',
							 :target_user_id => 2)
    Issue.create(:user_id => u.id,
							 :text => 'park issue new',
							 :target_user_id => 3)

    visit "/users/#{u.id}/issues"
    expect(all('article').count).to be(2)
  end

  it "shows the issues list where user is the target of the issue" do
    u = User.create(:identification_type => 'nif',
    					:identification_number => '12345678A',
    					:plate => '1234AAA', 
    					:extra_plates => 'false')

    Issue.create(:user_id => 1,
							 :text => 'park issue',
							 :target_user_id => u.id)
    Issue.create(:user_id => 2,
							 :text => 'park issue new',
							 :target_user_id => u.id)
    Issue.create(:user_id => 1,
							 :text => 'park issue newer',
							 :target_user_id => u.id)

    visit "/users/#{u.id}/issues"
    expect(all('article').count).to be(3)
  end

  it "show info message if doesnt get any issues where the user is the owner" do
    u = User.create(:identification_type => 'nif',
    					:identification_number => '12345678A',
    					:plate => '1234AAA', 
    					:extra_plates => 'false')

    visit "/users/#{u.id}/issues"
    expect(all('article').count).to be(0)
    expect(page.has_css?('p.empty_issues_message')).to be(true)
    expect(find('p.empty_issues_message').text).to eq('No has abierto ningún issue')
  end

  it "show info message if doesnt get any issues where the user is targeted" do
    u = User.create(:identification_type => 'nif',
    					:identification_number => '12345678A',
    					:plate => '1234AAA', 
    					:extra_plates => 'false')

    visit "/users/#{u.id}/issues"
    expect(all('article').count).to be(0)
    expect(page.has_css?('p.empty_issues_targeted_message')).to be(true)
  end


end