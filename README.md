# STAT440Project

## Makevars instructions
The stan model wouldn't compile because of compiler _warnings_ thrown by libboost and RcppEigen, which is completely out of my control.
Therefore, I needed to add the "-w" flag to CXX14FLAGS. This is a hack, I'll look into this later. 

I tested on three different environments (my linux desktop, studentcs environment, my macbook) and all three produced compiler warnings that only went away with the "-w" fix. 

For convenience, you can copy SAMPLE_MAKEVARS to ~/.R/Makevars. Or, manually add "-w" to CXX14FLAGS in your existing ~/.R/Makevars. 



