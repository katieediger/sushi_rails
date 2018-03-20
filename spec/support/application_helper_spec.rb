module ApplicationHelper
  def current_user
    @current_user ||= User.find_by(session[:user_id])
  end
  def current_organization
    @org_id = current_user.organization_id
  end
  def mock_auth_hash
   # The mock_auth configuration allows you to set per-provider (or default)
   # authentication hashes to return during integration testing.
   OmniAuth.config.mock_auth[:google] = {
     'provider' => 'google',
     'uid' => '123545',
     'info' => {
       'name' => 'mockuser',
       'location' => 'test_loc',
       'urls' => 'https://www.test.com',
       'image' => 'https://www.test.com/image.png'
     },
     'credentials' => {
       'token' => 'mock_token',
       'secret' => 'mock_secret'
     }
   }
  end
end
