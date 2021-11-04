# energy-simulator

Keeping the energy simulation code base here.

```
docker build -t gridlab .
```

```
$ mkdir test
$ cd test
$ git clone <gridlab-d tutorials>
$ docker run -t -i -v test:/test gridlab bash
```
The above command will make the test folder and its contents available as a volume in the linux machine within docker. within the bash interface you can start tmux and then start various processes there. I use the following tmux cheat sheet
https://tmuxcheatsheet.com/
