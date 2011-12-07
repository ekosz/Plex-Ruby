%w(Genre Writer Director Country).each { |type|
  eval <<-CLASS
module Plex
  class #{type}
    
    attr_reader :id, :tag

    def initialize(node)
      @id  = node.attr('id')
      @tag = node.attr('tag')
    end

  end
end
CLASS
}

module Plex
  class Role
    
    attr_reader :id, :tag, :role

    def initialize(node)
      @id   = node.attr('id')
      @tag  = node.attr('tag')
      @role = node.attr('role')
    end

  end
end
