# A 3D-printable flatbed knitting machine

## Note this is a dead Fork of the original
It has been updated so the code is easier to refer to but contains nothing of interest.
Please follow the main project here:
 - https://github.com/ScarlettSparks/KnittingMachine


## Changes:
- refactored code and addition of screws
- same shape as original when forked
- handle with two options added
- reorg of carriage to make booleans work better for the future and no flickering planes in the viewer

## Abandoned plans:
- There will be another repo about STGC (Single track Gray codes) in my collection:
  - This was designed so that a linear "absolute position" printed code could be laid along the rear of the carriage.
  - This would have enabled electronics, placed on the carriage, to accurately know (4900 steps) precisely where it was as it was moved along the needlbed.
  - Trivially this would be used as a row counter.
  - Less trivially a number of servos added to the carriage could have controlled the movement of the yarns and needle guides to allow:
     - multile color yarn changes
     - intarsia
     - single pass complex patterns instead of multi-row passes to make a pattern (as is current machine knitting deisgn)
     - etc
  - Power for this would come from a USB cable running alongside yarn, directed by some variation of overhead tension system.
