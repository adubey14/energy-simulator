# energy-simulator

Keeping the energy simulation code base here.

```
docker build -t gridlab .
```

```
$ mkdir test
$ cd test
$ git clone <gridlab-d tutorials>
$ docker run -t -i -v test:/test gridlab tmux
```
The above command will make the test folder and its contents available as a volume in the linux machine within docker. It  starts tmux.  You can create new windows using tmux short cuts and start mulitple processes in foregrounds. I use the following tmux cheat sheet https://tmuxcheatsheet.com/
