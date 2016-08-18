class UserExtra < ActiveResource::Base
    self.headers['Authorization'] ='Token token="Bearer eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJzZXJ2aWNlIjoicm9ib2RvdS5jbiJ9.msXlI5LQD2hnbZ2FdIzyB2b3dzDb_PQnMHFeHiNOFTk"'
    self.site = "http://i.s1.com"
    self.prefix = "/user_infos/:user_id/"
    self.element_name = "user_extra"
    def self.collection_name
      element_name
    end
    belongs_to :user_info
end
