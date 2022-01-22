# energy-simulator

Keeping the energy simulation code base here.

```
docker build -t gridlab .
```

```
$ mkdir test
$ cd test
# you can put any files in test and they will become available in the test folder in docker.
$ docker run -t -i -v test:/test gridlab bash
```
The above command will make the test folder and its contents available as a volume in the linux machine within docker. It also opens a bash shell.

Try running the following commands.

*  cd gridlab-tutorial/tutorials/1-DistributionFederation-ManualStart/
*  /start-session.sh

This will open 3 tmux windows. Run the following, one in each pane in the given order. (ctrl-b and arrow keys to cycle through panes)

*Note*:  The start session creates a tmux window session.  I use the following tmux cheat sheet https://tmuxcheatsheet.com/ to create new windows and switch between windows. Remember tmux is a command line screen mulitplexer. Take a look at windows and panes.  Here is an example of panes on the tmux we created.  You can switch between them using ctrl+b and arrow keys

<img width="1632" alt="tmux-inside-docker" src="https://user-images.githubusercontent.com/8484451/140398142-ec0ef24e-92e6-400d-a213-fe18235ae5b7.png">

Now run the following in the order, one in each pane

* helics_broker -f 2 --loglevel=3 --name=mainbroker
* python federate1.py
* cd /gridlab-tutorial/test_system_data/gldFeeders/B2/G_1/ && gridlabd DistributionSim_B2_G_1.glm



