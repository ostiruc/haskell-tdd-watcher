User Stories

- The program starts by giving one argument: the directory to watch
- When the program starts it runs the tests
- On a regular interval, the program will check to see if it should run new tests
- New tests are run only when any .hs file in the directory to watch (and any of its recursive sub-folders) has been modified since the last time tests were run
- When receiving an input of Ctrl-D, the program stops
- When running tests, the command 'cabal test' is run in directory being watched.
- When running tests, the ouptut of the command 'cabal test' is outputted by the program
