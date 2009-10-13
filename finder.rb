class Finder
  attr_reader :candidates
  
  def initialize(workspace, depth, expression)
    @workspace    = workspace
    @depth        = depth
    @expression   = Regexp.new(expression)
    @candidates   = []
    
    find_candidates
  end
  
  def only_one_candidate?
    @candidates.size == 1
  end
  
  protected
  
    def before_find_candidates
      Dir[File.join(@workspace, "**")]
    end
  
    def find_candidates(dirs = before_find_candidates, depth = 0)
      # Nothing to do
      return dirs if dirs.empty? || depth > @depth
      
      # Search for candidates at this depth
      dirs.each do |dir|
        @candidates << dir if dir =~ @expression
        find_candidates(Dir[File.join(dir, "**")], depth + 1)
      end
    end
end
