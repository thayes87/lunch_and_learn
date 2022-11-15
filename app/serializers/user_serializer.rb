class UserSerializer
  
  def self.new(user)
    {
      "data": {
        "type": "user",
        "id": user.id,
        "attributes": {
          "name": user.name,
          "email": user.email,
          "api_key": user.api_key
        }
      }
    }
  end

  def self.invalid_user
    {
      "data": ["Invalid Email"]
    }
  end
end