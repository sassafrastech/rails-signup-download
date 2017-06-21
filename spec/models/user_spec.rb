describe User do

  before(:each) {

    @user = User.new(email: 'user@example.com')
    Aws.config[:s3] = {stub_responses: true}
  }

  subject { @user }

  it { should respond_to(:email) }

  it "#email returns a string" do
    expect(@user.email).to match 'user@example.com'
  end

  describe '#remove_avatar' do
    it 'deletes the photo' do
      @user.remove_avatar('1')
      expect(@user.avatar).to eq nil
    end
  end

end
