include Warden::Test::Helpers
Warden.test_mode!

# Feature: User edit
#   As a user
#   I want to edit my user profile
#   So I can change my email address
feature 'User edit', :devise do

  before(:each) do
    @user = FactoryGirl.create(:user)
  end

  after(:each) do
    Warden.test_reset!
  end

  # Scenario: User changes email address
  #   Given I am signed in
  #   When I change my email address
  #   Then I see an account updated message
  scenario 'user changes email address' do
    login_as(@user, :scope => :user)
    visit edit_user_registration_path(@user)
    fill_in 'Email', :with => 'newemail@example.com'
    fill_in 'Current password', :with => @user.password
    click_button 'Update'
    txts = [I18n.t( 'devise.registrations.updated'), I18n.t( 'devise.registrations.update_needs_confirmation')]
    expect(page).to have_content(/.*#{txts[0]}.*|.*#{txts[1]}.*/)
  end

  # Scenario: User cannot edit another user's profile
  #   Given I am signed in
  #   When I try to edit another user's profile
  #   Then I see my own 'edit profile' page
  scenario "user cannot cannot edit another user's profile" do
    other = FactoryGirl.create(:user, email: 'other@example.com')
    login_as(@user, :scope => :user)
    visit edit_user_registration_path(other)
    expect(page).to have_content 'Edit User'
    expect(page).to have_field('Email', with: @user.email)
  end

  # Scenario: User adds a profile picture
  #   Given I am signed in
  #   When I add a new profile picture
  #   Then I see an account updated message
  scenario "user adds profile picture" do
    login_as(@user, :scope => :user)
    # visit edit_user_registration_path(@user)
    # fill_in { fixture_file_upload(Rails.root.join('app/assets/images/image1.png'), 'image/png') }
    # fill_in 'Current password', :with => @user.password
    # click_button 'Update'
    # txts = [I18n.t( 'devise.registrations.updated'), I18n.t( 'devise.registrations.update_needs_confirmation')]
    # expect(page).to have_content(/.*#{txts[0]}.*|.*#{txts[1]}.*/)

    # put '/users', users: { "avatar"=> <ActionDispatch::Http::UploadedFile:0x007fcca0e4c0e0 @tempfile=<Tempfile:/var/folders/4r/v4pzy1_j4rv9r0d9rp_gqd6w0000gn/T/RackMultipart20170619-68319-ab2dxs.jpg>, @original_filename="DCINER2UAAEE0F_.jpg", @content_type="image/jpeg", @headers="Content-Disposition: form-data; name=\"user[avatar]\"; filename=\"DCINER2UAAEE0F_.jpg\"\r\nContent-Type: image/jpeg\r\n"> }
  end


  # Scenario: User deletes a profile picture
  #   Given I am signed in
  #   When I click the checkbox to delete a profile picture
  #   Then I see an account updated message
  scenario "user deletes profile picture" do
    login_as(@user, :scope => :user)
    visit edit_user_registration_path(@user)
    page.check('Remove avatar')
    fill_in 'Current password', :with => @user.password
    click_button 'Update'
    txts = [I18n.t( 'devise.registrations.updated'), I18n.t( 'devise.registrations.update_needs_confirmation')]
    expect(page).to have_content(/.*#{txts[0]}.*|.*#{txts[1]}.*/)
end


end
