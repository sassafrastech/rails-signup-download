include Devise::Test::ControllerHelpers


describe MyDevise::RegistrationsController do



  describe 'PUT #update' do

    it "deletes user avatar" do
      put '/users', users: { "remove_avatar"=> 1 }

      expect(@user.avatar.url).to eq nil
    end

  end

end
