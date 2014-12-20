@dir = "/var/www/minecraft-site/"

# Number of processes
worker_processes 2

# Working directory
working_directory @dir

# Time-out
Timeout 30

# Unicorn socket
listen "#{dir}tmp/unicorn.minecraft-site.sock"

# Unicorn PID file location
pid "#{@dir}tmp/pids/unicorn.pid"

# Path to logs
stderr_path "#{@dir}logs/unicorn.log"
stdout_path "#{@dir}logs/unicorn.log"

