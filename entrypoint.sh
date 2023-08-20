#!/bin/bash
# docker entrypoint script.

# start the elixir app
echo "Executing Ecto migrations..."
eval "/app/bin/rinha_elixir eval \"RinhaElixir.Release.migrate\""

# start the elixir application
echo "Starting Rinha de Backend Elixir app..."

# the `exec` command is special because when used to execute a 
# command like running our service, it will replace the parent process 
# with the new process. 
# Now when Docker sends the SIGTERM signal to the process id,
# our Elixir app will trap the SIGTERM and gracefully shutting down.
exec "/app/bin/server" "start"