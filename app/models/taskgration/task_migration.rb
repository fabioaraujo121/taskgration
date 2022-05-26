module Taskgration
  class TaskMigration < ApplicationRecord

    ##
    # Scopes
    scope :newest, -> { order(created_at: :desc) }

    ##
    # Class Methods
    class << self
      def current_version
        newest.first.version
      end
    end
  end
end
