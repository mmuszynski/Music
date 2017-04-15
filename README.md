# Music - A framework for representing Music in the Swift programming language #

## What is represented? ##
### Object Types ###
* **MusicPitch** - A pitch with a name and accidental type in a given octave (note: unless otherwise specified, octaves will always refer to [Scientific Pitch Notation](https://en.wikipedia.org/wiki/Scientific_pitch_notation))
* **MusicRhythm** - A rhythm with a given duration
* **MusicInterval** - The distance between two given notes

### MusicCollection Protocol ###
Defines a protocol to be apllied to a collection of MusicPitch objects. The only requirement is that the object contains an Array of MusicPitch objects called "pitches". Further functionality, such as enumeration or indexing, is inferred through a default extension of the protocol, but can be overridden if necessary (See also: MusicTransposable).

The following types adopt MusicCollection, as they represent collections of notes:

* **MusicChord** - A collection of MusicPitches, defined with a root MusicPitch and the MusicIntervals used to describe the distance to the other pitches
* **MusicScale** - A collection of MusicPitches, defined by a root MusicPitch and the MusicIntervals used to describe the distance to the other pitches

### MusicTransposable Protocol ###

Music pitches can be transposed, or moved, in order to represent other pitches. For example, C0 transposed by a Major Third becomes E0. The MusicTransposable protocol should be adopted by any type that can be transposed by an interval. Default implementations are available for MusicPitch and types that adopt MusicPitchCollection (i.e. MusicChords can be transposed by transposing their individual pitches).

### Enumerable (Definition) Types ###
* **MusicPitchName** - The names, A-G (or Do-Ti), used in representing notes
* **MusicPitchAccidental** - The values for sharps, flats and natural used in describing pitches
* **MusicIntervalQuality** - The modifier for interval quality (e.g. Major, Minor, Diminished, Augmented, Perfect)
* **MusicIntervalQuantity** - The size of an interval, unison through octave, with a special generic case for intervals larger than an octave
* **MusicIntervalDirection** - The direction of an interval, up or down
* **MusicScaleMode** - The scale modes (major, minor, pentatonic, etc)

### Unsure what type at this point, but probably enumerable ###
* **MusicTimeSignature** - A description of the number of beats in each measure and their composition
* **MusicKeySignature** - A description of the flats and sharps in a given key signature

## Current Progress ##
### MusicPitch ###
MusicPitch is the basic description of where a pitch, the fundamental unit of musical notation. Note that pitches do not map directly to frequencies, so there is still some resolution required to match the physical production of the sound of a pitch. Thus frequency is not yet available in this library.

Similar to the way that Time and Date are backed by an integer number of seconds since an epoch in Cocoa, pitches are backed by an integer distance from the reference note C0. This reference is referred to as the Enharmonic Index, and by definition any two notes that are enharmonically equivalent will have the same index.

Pitches are generally initialized with a name, accidental, and octave, but can also be initialized using an initializer that requires the enharmonic index and the desired accidental. Since it will be impossible to represent a note at a given enharmonic index with all accidental types, this initializer returns nil if unable to compute a suitable pitch.

* Properties
    - Enharmonic Index (int): The number of half steps away from the reference pitch of C0
    - name (MusicPitchName): The name of the note
    - accidental (MusicPitchAccidental): The accidental of the note
    - octave (int): The octave for the note
#### Example Usage ####
```swift
//Using the standard initializer
let tuningNote = MusicPitch(name: MusicPitchName.a, accidental: MusicPitchAccidental.natural, octave: 4)
//Can also be initialized using the enharmonic index
let C0 = MusicPitch(enharmonicIndex: 0, accidental: .natural)
//Returns nil in cases where the Enharmonic Index and Accidental values cannot make a valid note
//In this example, there is no way to build an enharmonic equivalent to C0 using a flat
let noNote = MusicPitch(enharmonicIndex: 0, accidental: .flat)
noNote == nil //returns true
```

### MusicInterval ###
MusicInterval is the backbone of the MusicTransposable protocol, as it does computations that translate a certain pitch by a given interval.

* Properties
    - quality (MusicIntervalQuality): The quality as defined above
    - quantity (MusicIntervalQuantity): The quantity as defined above
* Functions
    - Computes destination pitch from a root pitch
    - Initializable from a range of pitches
#### Example Usage ####
```swift
let majorThird = MusicInterval(direction: .upward, quality: .major, quantity: .third)
let c0 = MusicPitch(name: .c, accidental: .natural, octave: 0)
let e0 = majorThird.destinationPitch(from: c0)
let alsoMajorThird = MusicInterval(rootPitch: c0, destinationPitch: e0)
```

## Further goals ##
* Integration with MusicStaffView for the display of pitches and rhythms
* Analysis tools for basic western Music Theory, including chord progression and voice leading
