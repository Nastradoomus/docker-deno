# Deno Docker Image
A tiny, Ubuntu-based Deno image. It spawns a "hello world" webserver.

## Running

To run, execute `./start.sh`. This will start a `docker-compose` service stack containing:
 * `app`: A simple Deno HTTP server that outputs "Hello World!"
 * `nginx`: The *extremely* popular Nginx reverse proxy that sits in front of the Deno server
 
## Implementation

This app, out of the box, will assume that you're running the server at the URL `https://deno.local`.
You'll need to map this hostname to your Docker Machine's IP address using whatever hosts file is appropriate
for your operating system.

 * `/etc/hosts` on linux/Mac
 * `c:\Windows\system32\drivers\etc\hosts` on Windows. (Run `Notepad.exe` in Administrator mode to edit this file).

## Running your own scripts

If you want to test out your own scripts instead of running the provided example server:

 * Mount your scripts folder to the `/app` folder in the container.
 * Provide a new `deno run` command to execute your script. Don't forget to allow the necessary permissions!

Example:
```
docker run --rm --name deno \
  -v /my/scripts/directory:/app:ro \
  torgie/deno.land:latest \
  deno run myScript.js
```
And to stop it:
```
docker stop deno
```
