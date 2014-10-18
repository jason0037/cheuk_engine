json.array!(@roles) do |role|
  json.extract! role, :id, :name,:role_code
  json.users role.roles_users
end
