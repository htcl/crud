# A sample Guardfile
# More info at https://github.com/guard/guard#readme

guard 'bundler' do
  watch(%r{.*\.gemspec})
  watch('Gemfile')
  # Uncomment next line if Gemfile contain `gemspec' command
  # watch(/^.+\.gemspec/)
end

guard 'rails', :root => 'spec/dummy', :debugger => true do
  watch(%r{.*\.gemspec})
  watch('Gemfile.lock')
  watch(%r{^(config|lib)/.*})
  watch(%r{^config/environments/.+\.rb$})
  watch(%r{^config/initializers/.+\.rb$})
  watch(%r{^spec/dummy/(config|lib)/.*})
  watch(%r{^spec/dummy/config/environments/.+\.rb$})
  watch(%r{^spec/dummy/config/initializers/.+\.rb$})
end

guard 'livereload' do
  watch(%r{app/views/.+\.(erb|haml|slim)})
  watch(%r{app/helpers/.+\.rb})
  watch(%r{public/.+\.(css|js|html)})
  watch(%r{config/locales/.+\.yml})
  # Rails Assets Pipeline
  watch(%r{(app|vendor)/assets/\w+/(.+\.(css|js|html)).*})  { |m| "/assets/#{m[2]}" }
end

guard 'spork', :wait => 60, :cucumber_env => { 'RAILS_ENV' => 'test' }, :rspec_env => { 'RAILS_ENV' => 'test' }, :test_unit_env => { 'RAILS_ENV' => 'test' } do
  watch(%r{.*\.gemspec})
  watch('config/application.rb')
  watch('config/environment.rb')
  watch('config/environments/test.rb')
  watch(%r{^config/initializers/.+\.rb$})
  watch(%r{^app/controllers/(.+)\.rb$})
  watch(%r{^app/models/(.+)\.rb$})
  watch(%r{^test/fixtures/(.+)\.yml$})
  watch(%r{^spec/factories/.+\.rb$})
  watch('Gemfile')
  watch('Gemfile.lock')
  watch('test/test_helper.rb') { :test_unit }
  watch('spec/spec_helper.rb') { :rspec }
  watch('spec/support/')       { :rspec }
  watch(%r{features/support/}) { :cucumber }
end

guard :test do
  watch(%r{^lib/(.+)\.rb$})     { |m| "test/#{m[1]}_test.rb" }
  watch(%r{^test/.+_test\.rb$})
  watch('test/test_helper.rb')  { "test" }

  # Rails example
  watch(%r{^app/models/(.+)\.rb$})                   { |m| "test/unit/#{m[1]}_test.rb" }
  watch(%r{^app/controllers/(.+)\.rb$})              { |m| "test/functional/#{m[1]}_test.rb" }
  watch(%r{^app/views/.+\.rb$})                      { "test/integration" }
  watch('app/controllers/application_controller.rb') { ["test/functional", "test/integration"] }
end

#guard 'rspec', :version => 2, :all_on_start => true, :cli => '--drb --profile --order random' do
guard :rspec, :all_on_start => true, :cmd => 'bundle exec rspec --profile --order random' do
  watch(%r{^spec/.+_spec\.rb$})
  watch(%r{^lib/(.+)\.rb$})     { |m| "spec/lib/#{m[1]}_spec.rb" }
  watch('spec/spec_helper.rb')  { "spec" }
  watch(%r{^.rspec$})           { "spec" }

  # Rails example
  watch(%r{^app/(.+)\.rb$})                           { |m| "spec/#{m[1]}_spec.rb" }
  watch(%r{^app/(.*)(\.erb|\.haml)$})                 { |m| "spec/#{m[1]}#{m[2]}_spec.rb" }
  watch(%r{^app/controllers/(.+)_(controller)\.rb$})  { |m| ["spec/routing/#{m[1]}_routing_spec.rb", "spec/#{m[2]}s/#{m[1]}_#{m[2]}_spec.rb", "spec/acceptance/#{m[1]}_spec.rb"] }
  watch(%r{^spec/support/(.+)\.rb$})                  { "spec" }
  watch(%r{^spec/factories/(.+)\.rb$})                { "spec" }
  watch('config/routes.rb')                           { "spec/routing" }
  watch('app/controllers/application_controller.rb')  { "spec/controllers" }

  # Capybara request specs
  watch(%r{^app/views/(.+)/.*\.(erb|haml)$})          { |m| "spec/requests/#{m[1]}_spec.rb" }

  # Turnip features and steps
  watch(%r{^spec/acceptance/(.+)\.feature$})
  watch(%r{^spec/acceptance/steps/(.+)_steps\.rb$})   { |m| Dir[File.join("**/#{m[1]}.feature")][0] || 'spec/acceptance' }
end

# default ':cli' is: '--no-profile --color --format progress --strict'
#guard 'RAILS_ENV=test cucumber', :cli => '--color --format progress --strict --exclude features/reports --verbose --backtrace' do
guard 'cucumber', :cli => '--drb --color --strict --exclude features/reports --backtrace' do
  watch(%r{^features/.+\.feature$})
  watch(%r{^features/support/.+$})          { 'features' }
  watch(%r{^features/step_definitions/(.+)_steps\.rb$}) { |m| Dir[File.join("**/#{m[1]}.feature")][0] || 'features' }
end
