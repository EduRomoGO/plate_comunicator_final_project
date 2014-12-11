require_relative '../rails_helper'

describe "User issues page", :type => :feature do

	let(:u) {User.create(:identification_type => 'nif',
    					:identification_number => '12345678A',
    					:plate => '1234AAA', 
    					:extra_plates => 'false')}

 	let(:create_test_issues_for_user) {Issue.create(:user_id => u.id,
																							 :text => 'park issue',
																							 :target_user_id => 2)
																	   Issue.create(:user_id => u.id,
																							 :text => 'park issue new',
																							 :target_user_id => 3)}

 	let(:create_test_issues_to_target_user) {Issue.create(:user_id => 1,
																										 :text => 'park issue',
																										 :target_user_id => u.id)
																			    Issue.create(:user_id => 2,
																										 :text => 'park issue new',
																										 :target_user_id => u.id)
																			    Issue.create(:user_id => 1,
																										 :text => 'park issue newer',
																										 :target_user_id => u.id)}

  xit "shows itself when visited" do
    visit '/users/1/issues'
  end

=begin
  xit "capybara test" do
    visit '/users/1/issues'
    page.should have_xpath('//p')
    expect(all('p').count).to be(1)
  end
=end


  it "shows the issues list where user is owner" do

  	create_test_issues_for_user

    visit "/users/#{u.id}/issues"
    expect(all('article').count).to be(2)
  end

  it "shows the issues list where user is the target of the issue" do

		create_test_issues_to_target_user

    visit "/users/#{u.id}/issues"
    expect(all('article').count).to be(3)
  end

  it "show info message if doesnt get any issues where the user is the owner" do

    visit "/users/#{u.id}/issues"
    expect(all('article').count).to be(0)
    expect(page.has_css?('p.empty_issues_message')).to be(true)
    expect(find('p.empty_issues_message').text).to eq('No has abierto ningún issue')
  end

  it "show info message if doesnt get any issues where the user is targeted" do

    visit "/users/#{u.id}/issues"
    expect(all('article').count).to be(0)
    expect(page.has_css?('p.empty_issues_targeted_message')).to be(true)
  end


  describe "has a form to create a new issue", :type => :feature do

	  it "that has a form tag" do

	    visit "/users/#{u.id}/issues"
	    expect(all('form').count).to be(1)
	  end

	  it "that has an input for the user plate" do

	    visit "/users/#{u.id}/issues"
	    expect(all('input#issue_target_user_id').count).to be(1)
	  end

	  it "where the input for the plate field is empty" do

	    visit "/users/#{u.id}/issues"
	    expect(find('input#issue_target_user_id').text).to eq("")
	  end

	  it "that has one and only one empty text input for the body of the the issue" do

	    visit "/users/#{u.id}/issues"
	    expect(all('input#issue_text').count).to be(1)
	    expect(find('input#issue_text').text).to eq("")
	  end

	  it "that has one button to submit the form" do

	    visit "/users/#{u.id}/issues"
	    expect(all('input[name="commit"]').count).to be(1)
	    expect(find('input[name="commit"]').value).to eq("Save")
	  end

	end

end