desc "Run guard"
task :guard do
  system %{bundle exec guard}
  #system %{cd spec/dummy && bundle exec guard --watchdir ../.. }
end
