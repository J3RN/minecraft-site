@dir = "/home/j3rn/minecraft-site/"

# Number of processes
worker_processes 2

# Working directory
working_directory @dir

# Time-out
timeout 30

# Unicorn socket
listen "#{@dir}tmp/sockets/unicorn.minecraft-site.sock", :backlog => 64

# Unicorn PID file location
pid "#{@dir}tmp/pids/unicorn.pid"

# Path to logs
stderr_path "#{@dir}logs/unicorn.log"
stdout_path "#{@dir}logs/unicorn.log"

