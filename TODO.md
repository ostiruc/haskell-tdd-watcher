# User Stories

- DONE - US.1 - The program starts by giving one argument: the directory to watch
- DONE - US.2 - When the program starts it runs the tests
- DONE - US.3 - On a regular interval, the program will check to see if it should run new tests
- DONE - US.4 - New tests are run only when any .hs file in the directory to watch (and any of its recursive sub-folders) has been modified since the last time tests were run
- ABANDONED - US.5 - When receiving an input of Ctrl-D, the program stops
- ALREADYWORKS - US.6 - When running tests, the command 'cabal test' is run in directory being watched.
- ALREADYWORKS - US.7 - When running tests, the ouptut of the command 'cabal test' is outputted by the program
- US.8 - When no argument is given, it watches the current directory

# Bugs

- DONE - B.1 - A failing test will stop the program; it should run and display the errors
