def rlog(stream = $stdout)
  ActiveRecord::Base.logger = Logger.new(stream)
  ActiveRecord::Base.connection_pool.clear_reloadable_connections!
end

def runlog(stream = $stdout)
  ActiveRecord::Base.logger = nil
  ActiveRecord::Base.connection_pool.clear_reloadable_connections!
end