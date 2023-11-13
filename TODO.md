User Stories

- DONE - US.1 - The program starts by giving one argument: the directory to watch
- US.2 - When the program starts it runs the tests
- US.3 - On a regular interval, the program will check to see if it should run new tests
- US.4 - New tests are run only when any .hs file in the directory to watch (and any of its recursive sub-folders) has been modified since the last time tests were run
- US.5 - When receiving an input of Ctrl-D, the program stops
- US.6 - When running tests, the command 'cabal test' is run in directory being watched.
- US.7 - When running tests, the ouptut of the command 'cabal test' is outputted by the program
- US.8 - When no argument is given, it watches the current directory
