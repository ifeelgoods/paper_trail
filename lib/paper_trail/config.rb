require 'singleton'

module PaperTrail
  class Config
    include Singleton
    attr_accessor :enabled, :timestamp_field, :serializer, :version_limit, :skip_blank_changes

    def initialize
      @enabled         = true # Indicates whether PaperTrail is on or off.
      @timestamp_field = :created_at
      @serializer      = PaperTrail::Serializers::YAML
      @skip_blank_changes = false
    end
  end
end
