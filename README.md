# Music #

# A framework for representing Music in the Swift programming language #

## What is represented? ##
### Object Types ###
* MusicPitch - A pitch with a name and accidental type in a given octave (note: unless otherwise specified, octaves will always refer to [Scientific Pitch Notation](https://en.wikipedia.org/wiki/Scientific_pitch_notation))
* MusicRhythm - A rhythm with a given duration
* MusicInterval - The distance between two given notes

### MusicCollection Protocol ###
Defines

### Collection Objects (see: MusicPitchCollection protocol) ###
* MusicChord - A collection of MusicPitches, defined by a root MusicPitch and the MusicIntervals used to describe the distance to the next pitches
* MusicScale - A collection of MusicPitches, defined by a root MusicPitch and the MusicIntervals used to describe the distance to the next pitch

### Enumerable Types ###
* MusicPitchName - The names, A-G (or Do-Ti), used in representing notes
* MusicPitchAccidental - The values for sharps, flats and natural used in describing pitches
* MusicIntervalQuality - The modifier for interval quality (e.g. Major, Minor, Diminished, Augmented, Perfect)
* MusicIntervalQuantity - The size of an interval, unison through octave, with a special generic case for intervals larger than an octave
* MusicIntervalDirection - The direction of an interval, up or down
* MusicScaleMode - The scale modes (major, minor, pentatonic, etc)

### Unsure what type at this point, but probably enumerable ###
* MusicTimeSignature - A description of the number of beats in each measure and their composition
* MusicKeySignature - A description of the flats and sharps in a given key signature

## Current Progress ##
### MusicPitch ###
* Properties
- Enharmonic Index (int): The number of half steps away from the reference pitch of C0
- name (MusicPitchName): The name of the note
- accidental (MusicPitchAccidental): The accidental of the note
- octave (int): The octave for the note
#### Example Usage ####
```swift
let tuningNote = MusicPitch(name: MusicPitchName.a, accidental: MusicPitchAccidental.natural, octave: 4)
```

### MusicInterval ###
* Properties
- quality (MusicIntervalQuality): The quality as defined above
- quantity (MusicIntervalQuantity): The quantity as defined above
* Functions
- Destination pitch from a root pitch
- Initializable from a range of pitches
#### Example Usage ####
```swift
let majorThird = MusicInterval(direction: .upward, quality: .major, quantity: .third)
let c0 = MusicPitch(name: .c, accidental: .natural, octave: 0)
let e0 = majorThird.destinationPitch(withRootPitch: c0)
let alsoMajorThird = MusicInterval(rootPitch: c0, destinationPitch: e0)
```

## Further goals ##
* Integration with MusicStaffView for the display of pitches and rhythms
* Analysis tools for basic western Music Theory, including chord progression and voice leading

### Next Steps ###
