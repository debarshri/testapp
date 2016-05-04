require 'logger'

class Logger

  class << self

    $logger = Logger.new($stdout)
    $logger.info("Starting build..")

    def info(msg)
      $logger.info("#{msg}")
    end

    def error(msg)
      $logger.error("#{msg}")
    end

  end
end