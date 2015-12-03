require 'spec_helper'
require "selenium-webdriver"

feature 'Create a two-round review assignment' do
  scenario 'without a topic', :js => true do
    login_with 'instructor6', 'password'
    expect(page).to have_content('Manage content')
    click_link( 'Assignments', match: :first)
    expect(page).to have_content('Manage content')
    #find(:xpath, "(//a[text()='Assignments'])[2]").click

    visit new_assignment_path
    expect(page).to have_content('New Assignment')
    fill_in 'Assignment name:', with: 'E1583_test_1'
    fill_in 'Submission directory', with: 'E1583_test_1'
    select "CSC/ECE 517, Spring 2015", :from => "assignment_form_assignment_course_id"

    click_button 'Create'
    expect(page).to have_content('You did not specify all necessary rubrics:')
    click_on 'Due dates'
    fill_in 'Number of review rounds:', with: '2'
    click_button 'Set'

    click_button 'Save'

    # Potential bug of expertiza, changes of the 'number of review rounds' 
    # will only take effect after click both the Set and Save button
    click_on 'Due dates'
 
    fill_in 'datetimepicker_submission_round_1', with: '2015/12/03 00:00'
    fill_in 'datetimepicker_review_round_1', with: '2015/12/06 00:00'
    fill_in 'datetimepicker_submission_round_2', with: '2015/12/11 00:00'
    fill_in 'datetimepicker_review_round_2', with: '2015/12/14 00:00'

    click_button 'Save'
    expect(page).to have_content('Assignment was successfully saved')
  end

  scenario 'with a topic', :js => true do
    login_with 'instructor6', 'password'
    expect(page).to have_content('Manage content')
    click_link( 'Assignments', match: :first)
    expect(page).to have_content('Manage content')
    #find(:xpath, "(//a[text()='Assignments'])[2]").click

    visit new_assignment_path
    expect(page).to have_content('New Assignment')
    fill_in 'Assignment name:', with: 'E1583_test_2'
    fill_in 'Submission directory', with: 'E1583_test_2'
    select "CSC/ECE 517, Spring 2015", :from => "assignment_form_assignment_course_id"
    #check 'assignment_form_assignment_staggered_deadline'

    click_button 'Create'
    expect(page).to have_content('You did not specify all necessary rubrics:')
    
    click_on 'Topics'
    expect(page).to have_content('Signup topics have not yet been created.')

    click_on 'New topic'

    expect(page).to have_content('You are adding a topic to this assignment.')
    click_button('OK')
    expect(page).to have_content('Number of slots')
    fill_in 'topic_topic_identifier', with: '999'
    fill_in 'topic_topic_name', with: 'E1583_test_2_topic'
    fill_in 'topic_category', with: 'E1583'
    fill_in 'topic_max_choosers', with: '3'
    click_button 'Create'

    click_on 'Due dates'
    fill_in 'Number of review rounds:', with: '2'
    click_button 'Set'

    click_button 'Save'
    #expect(page).to have_content('Assignment was successfully saved')

    
    # Potential bug of expertiza, changes of the 'number of review rounds' 
    # will only take effect after click both the Set and Save button
    click_on 'Due dates'
 
    fill_in 'datetimepicker_submission_round_1', with: '2015/12/03 00:00'
    fill_in 'datetimepicker_review_round_1', with: '2015/12/06 00:00'
    fill_in 'datetimepicker_submission_round_2', with: '2015/12/11 00:00'
    fill_in 'datetimepicker_review_round_2', with: '2015/12/14 00:00'

    click_button 'Save'
    expect(page).to have_content('Assignment was successfully saved')
  end

  def login_with(username, password)
    visit root_path
    fill_in 'login_name', with: username
    fill_in 'login_password', with: password
    click_button 'SIGN IN'
  end
end
