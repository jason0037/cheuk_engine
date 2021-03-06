worker_processes 30
preload_app true
timeout 300
listen 80

require 'pathname'

path = Pathname.new(__FILE__).realpath # 当前文件完整路径

path = path.sub('/config/unicorn.rb', '')

APP_PATH = path.to_s

#pid 日志

pid APP_PATH + "/tmp/pids/unicorn.pid"

# unicorn 日志

stderr_path APP_PATH + "/log/unicorn.stderr.log"

stdout_path APP_PATH + "/log/unicorn.stdout.log"

after_fork do |server, worker|
  ActiveRecord::Base.establish_connection
end