%w(Genre Writer Director Country).each { |type|
  eval <<-CLASS
module Plex
  class #{type}
    
    attr_reader :id, :tag

    def initialize(options)
      @id  = options['id']
      @tag = options['tag']
    end

  end
end
CLASS
}

module Plex
  class Role
    
    attr_reader :id, :tag, :role

    def initialize(options)
      @id   = options['id']
      @tag  = options['tag']
      @role = options['role']
    end

  end
end
