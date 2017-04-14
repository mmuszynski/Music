# Music #

# A framework for representing Music in the Swift programming language #

## What will be represented? ##
### Object Types ###
* MusicPitch - A pitch with a name and accidental type in a given octave (note: unless otherwise specified, octaves will always refer to [Scientific Pitch Notation](https://en.wikipedia.org/wiki/Scientific_pitch_notation))
* MusicRhythm - A rhythm with a given duration
* MusicInterval - The distance between two given notes

###Collection Objects (see: MusicPitchCollection protocol)###
* MusicChord - A collection of MusicPitches, defined by a root MusicPitch and the MusicIntervals used to describe the distance to the next pitches
* MusicScale - A collection of MusicPitches, defined by a root MusicPitch and the MusicIntervals used to describe the distance to the next pitch

###Enumerable Types###
* MusicPitchName - The names, A-G (or Do-Ti), used in representing notes
* MusicPitchAccidental - The values for sharps, flats and natural used in describing pitches
* MusicIntervalQuality - The modifier for interval quality (e.g. Major, Minor, Diminished, Augmented, Perfect)
* MusicIntervalQuantity - The size of an interval, unison through octave, with a special generic case for intervals larger than an octave
* MusicScaleMode - The scale modes (major, minor, pentatonic, etc)

###Unsure what type at this point, but probably enumerable###
* MusicTimeSignature - A description of the number of beats in each measure and their composition
* MusicKeySignature - A description of the flats and sharps in a given key signature

##Current Progress##
###MusicPitch###
* Properties
    - Enharmonic Index (int): The number of half steps away from the reference pitch of C0
    - name (MusicPitchName): The name of the note
    - accidental (MusicPitchAccidental): The accidental of the note
    - octave (int): The octave for the note
* Example:
```swift
    let tuningNote = MusicPitch(name: MusicPitchName.a, accidental: MusicPitchAccidental.natural, octave: 4)
```

## Further goals ##
* Integration with MusicStaffView for the display of pitches and rhythms
* Analysis tools for basic western Music Theory, including chord progression and voice leading

### Next Steps ###
