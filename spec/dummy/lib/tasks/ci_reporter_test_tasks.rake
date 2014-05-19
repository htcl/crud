#
# Wrapper tasks for ci_reporter
#
namespace :ci do
  desc 'install required migrations from vendor gems'
  task :install_vendor_migrations do
    #files =
    #  Dir.glob(File.join('db', 'migrate', '*.{core}.rb')) +
    #  Dir.glob(File.join('spec', 'dummy', 'db', 'migrate', '*.{core}.rb'))
    #files.each { |f| rm f }

    #Dir.chdir 'spec/dummy' do
    #  system('bundle exec rake core:install:migrations')
    #end if File.directory?('spec/dummy')
  end

  desc "Run unit tests within the ci_reporter environment"
  #task :unit_tests  => %w(test)
  task :unit_tests  => %w(ci:setup:testunit test)
  #task :unit_tests  => %w(ci:setup:testunit test rcov:test)

  desc "Run functional test/rspecs within the ci_reporter environment"
  #task :functional_tests  => %w(spec)
  task :functional_tests  => %w(ci:setup:rspec spec)
  #task :functional_tests  => %w(ci:setup:rspec spec:rcov)
  #task :functional_tests  => %w(ci:setup:rspec rcov:rspec)

  desc "Run integration tests/features within the ci_reporter environment"
  #task :integration_tests  => %w(cucumber)
  #task :integration_tests  => %w(ci:setup:cucumber cucumber) # does not work
  task :integration_tests do
    Rake::Task['ci:setup:cucumber_report_cleanup'].invoke
    #ENV['CUCUMBER_OPTS'] = "#{ENV['CUCUMBER_OPTS']} --require features"
    ENV['CUCUMBER_OPTS'] = "#{ENV['CUCUMBER_OPTS']} --format CI::Reporter::Cucumber"
    Rake::Task['cucumber'].invoke
  end
  #task :integration_tests  => %w(rcov:cucumber)

  desc "Run all tests within the ci_reporter environment"
  task :all_tests do
    system('bundle exec rake db:drop db:create db:migrate RAILS_ENV=test')
    unless RbConfig::CONFIG['host_os'] =~ /mswin|mingw/
      system('bundle exec rake app:ci:functional_tests app:ci:integration_tests RAILS_ENV=test')
    else
      system('bundle exec rake app:ci:functional_tests RAILS_ENV=test')
    end
  end

  desc 'Deletes RCov artifacts'
  task :clear do
    remove_dir('coverage') if File.directory?('coverage')
    rm "coverage.data" if File.exist?("coverage.data")
  end

  desc "Clean and run all tests within the ci_reporter environment"
  task :all => [:clear, :install_vendor_migrations, :all_tests]
end
