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
The above command will make the test folder and its contents available as a volume in the linux machine within docker. It  starts tmux.  You can create new windows using tmux short cuts and start mulitple processes (create new windows) in foregrounds. I use the following tmux cheat sheet https://tmuxcheatsheet.com/ to create new windows and switch between windows. Remember tmux is a command line screen mulitplexer. Take a look at windows and panes.  Here is an example of a panes on the tmux we created. 


<img width="1632" alt="tmux-inside-docker" src="https://user-images.githubusercontent.com/8484451/140398142-ec0ef24e-92e6-400d-a213-fe18235ae5b7.png">
