class User < ActiveRecord::Base
  has_many :reviews
  has_secure_password # adds 2 methods to user objects. lets you set a password, which cannot be set without this.
end
