# Music #

# A framework for representing Music in the Swift programming language #

## What will be represented? ##
### Object Types ###
* MusicPitch - A pitch with a name and accidental type in a given octave
* MusicRhythm - A rhythm with a given duration
* MusicInterval - The distance between two given notes

###Collection Objects (see: MusicPitchCollection protocol)###
* MusicChord - A collection of MusicPitches, defined by a root MusicPitch and the MusicIntervals used to describe the distance to the next pitches
* MusicScale - A collection of MusicPitches, defined by a root MusicPitch and the MusicIntervals used to describe the distance to the next pitch

###Enumerable Types###
* MusicTimeSignature - A description of the number of beats in each measure and their composition
* MusicKeySignature - A description of the flats and sharps in a given key signature

##Current Progress##
###MusicPitch###
* Properties
    - INT: Enharmonic Index

## Further goals ##
* Integration with MusicStaffView for the display of pitches and rhythms
* Analysis tools for basic western Music Theory, including chord progression and voice leading

### Next Steps ###
