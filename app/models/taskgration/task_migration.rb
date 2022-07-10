module Taskgration
  class TaskMigration < ApplicationRecord

    ##
    # Scopes
    scope :newest, -> { order(version: :desc) }

    ##
    # Class Methods
    class << self
      def current_version
        newest.first&.version
      end
    end
  end
end
