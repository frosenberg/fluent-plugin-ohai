
module Fluent
  class OhaiInput < Input

    Plugin.register_input('ohai', self)

    def initialize
      require 'open3'
      require 'json'
      super
    end

    config_param :tag, :string, :default => "ohai.message"
    config_param :hostname, :string, :default => ENV["HOSTNAME"]
    config_param :ohai_path, :string, :default => nil
    config_param :option, :string, :default => nil
    config_param :interval, :string, :default => '1200m' # 24h

    def configure(conf)
      super      
      @ohai_cmd = 'ohai'
      if @ohai_path
        @ohai_cmd = File.join(@ohai_path, @ohai_cmd) 
      end

      @interval = Config.time_value(@interval)
    end

    def start

      # check whether 'ohai' is installed
      begin 
        stdout, stderr, status = Open3.capture3("#{@ohai_cmd} -v")
        if !status.success? || /Ohai/.match(stdout).nil?
          log.error "'ohai' executable does not return desired output. Ignoring plugin ..."
        end
        log.debug "stdout for 'ohai -v' test: #{stdout}"
        log.debug "stderr for 'ohai -v' test: #{stderr}"

      rescue Errno::ENOENT => e 
        log.error "'ohai' executable not found. Ingoring plugin ..."
      end

      @thread = Thread.new(&method(:run))
    end

    def shutdown
      Thread.kill(@thread)
    end

    def run

      loop do 
                      
        begin
          stdout, stderr, status = Open3.capture3(@ohai_cmd)
          if status.success?                
            # replace hostname if user configured it this way
            json = JSON.parse(stdout)
            json['hostname'] = @hostname
            now = Engine.now
            log.info "['#{now}'] Emitting ohai data"
            Engine.emit("#{@tag}", now, json)
          else
            log.error "Command '#{@ohai_cmd}' failed with exit code #{status} and message '#{stderr}'"          
          end
        rescue StandardError => e
          log.error "ohai-plugin: failed to run ohai."
          log.error "error: #{e.message}"
          log.error e.backtrace.join("\n")
        end
        sleep @interval      
      end
    end

  end
end
