# Directory `src`

This directory is designed to include *environments* and *products* in a directory structure like this:

    / Repository Root
       |
       +-->src                   # Source files including unzipped CSAR
       |    +-> lab              # Lab environment
       |    |     |-> EMS        # Product subdirectories
       |    |     |-> PSX
       |    |     |-> SBC
       |    |     |-> VNFM
       |    |
       |    +-> production       # Production environment
       |           |-> EMS       # Product subdirectories
       |           |-> PSX
       |           |-> SBC
       |           |-> VNFM

This file is here to insure that the src directory is preserved in git. You can remove this file after environments have been populated.
