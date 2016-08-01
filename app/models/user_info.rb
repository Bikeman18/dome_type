class UserInfo < ActiveResource::Base
    self.headers['Authorization'] = ENV['AuthorizationHeader']
    self.site = "http://localhost:3000"
end
