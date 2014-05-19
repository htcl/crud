# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ :name => 'Chicago' }, { :name => 'Copenhagen' }])
#   Mayor.create(:name => 'Daley', :city => cities.first)

require 'active_record/fixtures'

require 'csv'

private

def import_data(dir, always = false)
  #load_fixtures(dir, always)
  load_csv_fixtures(dir, always)
  load_acl_mappings(dir, always)
  load_complex_seeds(dir, always)
end

def load_fixtures(dir, always = false)
  development_seed_dir = (Rails.env == 'production') ? dir.gsub(/production/,'development') :
    (Rails.env == 'test') ? dir.gsub(/test/,'development') :
    dir
  seed_files_from_development_environment = Dir.glob(File.join(Rails.root, 'db', development_seed_dir, '*.yml')).sort
  seed_files_from_current_environment = Dir.glob(File.join(Rails.root, 'db', dir, '*.yml')).sort

  seed_files_from_development_environment.each do |fixture_file_from_development_environment|
    fixture_file = fixture_file_from_development_environment
    fixture_dir = development_seed_dir
    fixture_environment = 'development'

    # If there is a seed file for the current environment (Rails.env), use that instead of the development one
    seed_files_from_current_environment.each do |fixture_file_from_current_environment|
      if fixture_file_from_current_environment.include?(File.basename(fixture_file, '.*'))
        fixture_file = fixture_file_from_current_environment
        fixture_dir = dir
        fixture_environment = dir.include?('common') ? 'common' : Rails.env
      end
    end

    table_name = File.basename(fixture_file, '.*')

    if table_empty?(table_name) || always || dir.include?("#{Rails.env}")
      puts "Loading '#{table_name}' table (#{fixture_environment})"
      truncate_table(table_name)
      ActiveRecord::Fixtures.create_fixtures(File.join('db/', fixture_dir), table_name)
    else
      puts "Skipped '#{table_name}' table"
    end
  end
end

def load_csv_fixtures(dir, always = false)
  development_seed_dir = (Rails.env == 'production') ? dir.gsub(/production/,'development') :
    (Rails.env == 'test') ? dir.gsub(/test/,'development') :
    dir
  seed_files_from_development_environment = Dir.glob(File.join(Rails.root, 'db', development_seed_dir, '*.{yml,csv}')).sort
  seed_files_from_current_environment = Dir.glob(File.join(Rails.root, 'db', dir, '*.{yml,csv}')).sort

  seed_files_from_development_environment.each do |fixture_file_from_development_environment|
    fixture_file = fixture_file_from_development_environment
    fixture_dir = development_seed_dir
    fixture_environment = 'development'

    # If there is a seed file for the current environment (Rails.env), use that instead of the development one
    seed_files_from_current_environment.each do |fixture_file_from_current_environment|
      if fixture_file_from_current_environment.include?(File.basename(fixture_file, '.*'))
        fixture_file = fixture_file_from_current_environment
        fixture_dir = dir
        fixture_environment = dir.include?('common') ? 'common' : Rails.env
      end
    end

    # reconstruct class and table names
    parts = File.basename(fixture_file, '.*').gsub(/(\d+)_/,'').split('-')
    #parts.map! { |item| item.camelize }
    #class_name = parts.join('::').classify
    parts.map! { |item| item.classify }
    class_name = parts.join('::')
    table_name = File.basename(fixture_file, '.*').gsub(/(\d+)_/,'').gsub(/-/, '_')

    if table_empty?(table_name) || always || dir.include?("#{Rails.env}")
      print "Loading '#{table_name}' table (#{class_name})"
      STDOUT.flush
      truncate_table(table_name)
      load_csv_file(fixture_file, class_name)
      puts " - done"
    else
      puts "Skipped '#{table_name}' table"
    end
  end
end

def load_complex_seeds(dir, always = false)
  development_seed_dir = (Rails.env == 'production') ? dir.gsub(/production/,'development') :
    (Rails.env == 'test') ? dir.gsub(/test/,'development') :
    dir
  seed_files_from_development_environment = Dir.glob(File.join(Rails.root, 'db', development_seed_dir, '*.{rb}')).sort
  seed_files_from_current_environment = Dir.glob(File.join(Rails.root, 'db', dir, '*.{rb}')).sort

  seed_files_from_development_environment.each do |seed_file_from_development_environment|
    seed_file = seed_file_from_development_environment

    # If there is a seed file for the current environment (Rails.env), use that instead of the development one
    seed_files_from_current_environment.each do |seed_file_from_current_environment|
      seed_file = seed_file_from_current_environment if seed_file_from_current_environment.include?(File.basename(seed_file, '.*'))
    end

    table_name = File.basename(seed_file, '.*').gsub(/(\d+)_/,'')

    if table_empty?(table_name) || always || dir.include?("#{Rails.env}")
      puts "Running '#{seed_file}' (#{table_name})"
      require seed_file
    else
      puts "Skipped '#{table_name}' table"
    end
  end
end

# Populate acl_mapping definitions
def load_acl_mappings(dir, always = false)
  development_seed_dir = (Rails.env == 'production') ? dir.gsub(/production/,'development') :
    (Rails.env == 'test') ? dir.gsub(/test/,'development') :
    dir
  seed_files_from_development_environment = Dir.glob(File.join(Rails.root, 'db', development_seed_dir, 'data', 'sys_acl_mappings*.{csv}')).sort
  seed_files_from_current_environment = Dir.glob(File.join(Rails.root, 'db', dir, 'data', 'sys_acl_mappings*.{csv}')).sort

  seed_files_from_development_environment.each do |seed_file_from_development_environment|
    seed_file = seed_file_from_development_environment
    seed_file_environment = 'development'

    # If there is a seed file for the current environment (Rails.env), use that instead of the development one
    seed_files_from_current_environment.each do |seed_file_from_current_environment|
      seed_file = seed_file_from_current_environment if seed_file_from_current_environment.include?(File.basename(seed_file, '.*'))
      seed_file_environment = dir.include?('common') ? 'common' : Rails.env
    end

    table_name = File.basename(seed_file, '.*').gsub(/(.*)-.*/,'\1')
    domain_name = File.basename(seed_file, '.*').gsub(/.*-(.*)/,'\1')
    puts "Parsing '#{File.basename(seed_file, '.*')}' (#{seed_file_environment}/#{table_name}/#{domain_name})"

    sys_domain = SysDomain.find_by_url( (domain_name == 'default') ? nil : domain_name )

    line_no = -1
    #CSV.foreach(seed_file, :headers => true, :skip_blanks => true) do |row|
    #CSV.foreach(seed_file, :headers => true) do |row|
    CSV.foreach(seed_file) do |row|
      #CSV.open(seed_file, 'r') do |row|
      #CSV.foreach(seed_file, {:headers => true, :skip_blanks => true}) do |row|
      #input_data = CSV.new(seed_file, {:headers => true, :skip_blanks => true})
      #input_data.open() do |row|

      line_no += 1

      next if line_no == 0 # Assume and ignore header row
      #break if line_no > 2

      sys_user_role_name = row[6]
      sys_user_role =
        SysUserRole.find_by_name_and_sys_domain_id(sys_user_role_name, sys_domain.id) ||
        SysUserRole.create(:name => sys_user_role_name, :comment => sys_user_role_name, :sys_domain => sys_domain)

      record = SysAclMapping.new(
        :object_name   => row[0],
        :field_name    => row[1],
        :can_create    => row[2],
        :can_read      => row[3],
        :can_update    => row[4],
        :can_delete    => row[5],
        :sys_user_role => sys_user_role
      )
      record.save!
      print "." if line_no % 25 == 0
      STDOUT.flush

    end if sys_domain
    print "*\n"
    STDOUT.flush
  end
end

def load_csv_file(filename, class_name)

  klass = class_name
  line_no = 0
  keys = []

  CSV.foreach(filename) do |row|

    if line_no == 0
      # First row is a header
      row.each do |field|
        keys << field
      end
    else
      # data
      attributes = {}
      field_number = 0
      keys.each do |key|
        attributes[ key ] = (row[field_number].blank? ? nil : row[field_number])
        field_number += 1
      end

      #attributes.each do |attribute|
      #  print "#{attribute} "
      #end
      #print "\n"

      record = klass.constantize.new(attributes)
      record.save!
    end

    line_no += 1

    # Give some feedback for long running imports
    #print "." if line_no % 25 == 0
  end

  #print "\n" if line_no > 25
end

def table_empty?(table_name)
  quoted = connection.quote_table_name(table_name)
  connection.select_value("SELECT COUNT(*) FROM #{quoted}").to_i.zero?
end

def truncate_table(table_name)
  quoted = connection.quote_table_name(table_name)
  connection.execute("DELETE FROM #{quoted}")
end

def connection
  ActiveRecord::Base.connection
end

puts "ENVIRONMENT: #{Rails.env}"
puts "Loading common seeds"
import_data "seed/once/common"
import_data "seed/always/common", :always

puts ""

puts "Loading #{Rails.env} seeds"
import_data "seed/once/#{Rails.env}"
import_data "seed/always/#{Rails.env}", :always
