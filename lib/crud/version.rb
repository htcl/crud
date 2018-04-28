module Crud
  # Returns the version of the currently loaded gem as a <tt>Gem::Version</tt>
  def self.gem_version
    Gem::Version.new VERSION::STRING
  end

  def self.version
    VERSION::STRING.to_f
  end

  module VERSION
    MAJOR = 0
    MINOR = 1
    PATCH = 0
    PRE   = nil

    STRING = [MAJOR, MINOR, PATCH, PRE].compact.join(".")
  end
end
