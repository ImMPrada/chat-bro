# db/seeds.rb

puts "🌱 Seeding database..."

# Create OAuth Application for Frontend
oauth_app = Doorkeeper::Application.find_or_create_by!(name: "Chat-Bro Frontend") do |app|
  app.redirect_uri = "urn:ietf:wg:oauth:2.0:oob"
  app.scopes = "public"
  app.confidential = false
end

puts "✅ OAuth Application created:"
puts "   Name: #{oauth_app.name}"
puts "   Client ID: #{oauth_app.uid}"
puts "   Client Secret: #{oauth_app.secret}"
puts ""

# Load roles from YAML
puts "📋 Loading roles from data/roles.yml..."
roles_data = YAML.load_file(Rails.root.join("data", "roles.yml"))

roles_data.each do |role_data|
  role = UsersEngine::Role.find_or_create_by!(code: role_data["code"])
  puts "✅ Role created: #{role.code}"

  # Create features from feature_patterns
  role_data["feature_patterns"]&.each do |feature_code|
    feature = UsersEngine::Feature.find_or_create_by!(code: feature_code) do |f|
      f.description = "Access to #{feature_code}"
    end

    # Assign feature to role
    UsersEngine::RoleFeature.find_or_create_by!(
      role: role,
      feature: feature
    )
  end
end

# Load work positions from YAML
puts "\n👔 Loading work positions from data/work_positions.yml..."
work_positions_data = YAML.load_file(Rails.root.join("data", "work_positions.yml"))

work_positions_data.each do |position_data|
  position = PersonasEngine::WorkPosition.find_or_create_by!(code: position_data["code"]) do |p|
    p.title_matches = position_data["title_matches"]
  end
  puts "✅ Work position created: #{position.code}"
end

# Create test user
puts "\n👤 Creating test user..."
role_nivel_1 = UsersEngine::Role.find_by!(code: "nivel_1")
test_user = UsersEngine::User.find_or_create_by!(email: "test@chatbro.com") do |user|
  user.role = role_nivel_1
  user.status = :active
end

puts "✅ Test user created:"
puts "   Email: #{test_user.email}"
puts "   Status: #{test_user.status}"
puts ""

puts "🎉 Seeding complete!"
puts ""
puts "Next steps:"
puts "1. Start Rails server: rails s -p 3001"
puts "2. OAuth Application credentials:"
puts "   Client ID: #{oauth_app.uid}"
puts "   Client Secret: #{oauth_app.secret}"
puts ""
puts "Note: UsersEngine uses passwordless authentication (OTP/magic links)."
puts "For testing, you'll need to implement the appropriate authentication flow."
