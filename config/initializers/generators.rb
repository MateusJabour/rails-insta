Rails.application.config.generators do |g|
  g.orm :active_record, primary_key_type: :uuid
  g.test_framework :test_unit, fixture: false
  g.assets = false
  g.helper = false
  g.skip_routes = true
end
