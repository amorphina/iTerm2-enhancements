# iTerm2-enhancements

* Add this code to your .profile file and whenever you connect to a server the tab name will change to the hostname of the server.
* The code will also change the color of the tab. The color is generated based on the hostname of the server, so you will always get the same color for one and the same server but different colors for different servers.

## How it works

* Include the code to the .profile file in your home directory so it is loaded whenever you open a new tab with iTerm2.
* The ssh command is replaced by an alias, which will first change the tab name and color and afterwards initiate the ssh command with all arguments passed to it.
