require 'logger'

class Logger

  class << self

    $logger = Logger.new($stdout)

    def info(msg)
      $logger.info("#{msg}")
    end

    def error(msg)
      $logger.error("#{msg}")
    end

  end
end