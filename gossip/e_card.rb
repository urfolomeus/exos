module Gossip

  class ECard

    def self.find(id)
      # This is really the #find from ActiveRecord
      raise NotImplementedError
    end

    attr_reader :id, :created_by, :recipient
    def initialize(options = {})
      @id = options[:id]
      @created_by = options[:created_by]
      @recipient = options[:recipient]
    end

    def permalink
      "http://example.com/ecards/#{id}"
    end

  end

end
