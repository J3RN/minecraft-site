# Minecraft Site

This site showcases the stats for the players on a Minecraft server, and maybe someday more!

## Current functionality

Current, the site simply displays:
* Number of deaths
* Number of deaths to hostile mobs for each mob (e.g. "Times killed by Skeleton")
* Number of kills of hostile mobs for each mob (e.g. "Skeletons killed")

## Setup

**Unfinished**: I still need to look into how to properly deploy Sinatra apps

All you need to do is set an environment variable to point to the Minecraft stats directory:
```zsh
export STATS_PATH=/home/j3rn/minecraft/world/stats
```

## Contributing

Contributions are welcome! Simply follow the guide below.

1. Fork the repository
2. Create a topic branch
3. Commit your changes to the topic branch
4. Open a pull-request from your topic branch to the master branch
