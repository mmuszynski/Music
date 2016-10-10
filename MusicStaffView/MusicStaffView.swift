//
//  MusicStaffView.swift
//  MusicStaffView
//
//  Created by Mike Muszynski on 1/4/15.
//  Copyright (c) 2015 Mike Muszynski. All rights reserved.
//

import UIKit

@IBDesignable class MusicStaffView: UIView {
    
    @IBInspectable var previewNotes: Int = 8 {
        didSet {
            self.setupLayers()
        }
    }
    
    private var _noteArray: [MusicStaffViewNote] = []
    public var noteArray: [MusicStaffViewNote] {
        get {
            #if TARGET_INTERFACE_BUILDER
                let testArray = [MusicStaffViewNote(name: .c, accidental: .none, length: .quarter, octave: 4),
                                 MusicStaffViewNote(name: .b, accidental: .none, length: .quarter, octave: 4),
                                 MusicStaffViewNote(name: .d, accidental: .none, length: .quarter, octave: 4)]
                return testArray
            #else
                return _noteArray
            #endif
        }
        set {
            _noteArray = newValue
        }
    }
    
    @IBInspectable var maxLedgerLines : Int = 0 {
        didSet {
            self.setupLayers()
        }
    }
    @IBInspectable var preferredHorizontalSpacing : CGFloat = 0 {
        didSet {
            self.setupLayers()
        }
    }
    @IBInspectable var displayedClef : ClefType = .treble {
        didSet{
            self.setupLayers()
        }
    }
    @IBInspectable var debug : Bool = false {
        didSet{
            self.setupLayers()
        }
    }
    var noteNameForFirstNote: NoteName = .b {
        didSet {
            self.setupLayers()
        }
    }
    
    override var bounds : CGRect {
        didSet {
            self.setupLayers()
        }
    }
    
    
    var spaceWidth : CGFloat {
        get {
            return self.bounds.size.height / (6.0 + 2.0 * CGFloat(maxLedgerLines))
        }
    }
    
    var drawAllAccidentals : Bool = false
    var staffLayer : MusicStaffViewStaffLayer
    
    required init(coder aDecoder: NSCoder) {
        staffLayer = MusicStaffViewStaffLayer()
        super.init(coder: aDecoder)!
    }
    
    override init(frame: CGRect) {
        staffLayer = MusicStaffViewStaffLayer()
        super.init(frame: frame)
        self.setupLayers()
    }
    
    func setupLayers() {
        staffLayer.removeFromSuperlayer()
        staffLayer = MusicStaffViewStaffLayer()
        self.drawStaffInRect(self.bounds)
        self.drawClef(displayedClef, atHorizontalPosition: 0.0)
        
        for i in 0..<noteArray.count {
            
            let note = noteArray[i]
            
            self.drawNote(note.name, octave: note.octave, accidental: note.accidental, length: note.length, atHorizontalPosition: staffLayer.currentHorizontalPosition +
                preferredHorizontalSpacing, forcedDirection: nil)
        }
        
    }
    
    func drawStaffInRect(_ rect: CGRect) {
        staffLayer.frame = rect
        staffLayer.maxLedgerLines = self.maxLedgerLines
        if debug {
            staffLayer.backgroundColor = UIColor(red: 1.0, green: 0, blue: 0, alpha: 0.25).cgColor
        }
        self.layer.addSublayer(staffLayer)
    }
    
    func drawClef(_ type: ClefType, atHorizontalPosition xPosition: CGFloat) {
        let clefLayer = MusicStaffViewElementLayer(type: .clef(type))
        clefLayer.height = 6.5 * spaceWidth
        clefLayer.position = CGPoint(x: xPosition, y: self.bounds.size.height / 2.0 + spaceWidth)
        staffLayer.addSublayer(clefLayer)
    }
    
    func drawNote(_ name: NoteName, octave: Int, accidental: AccidentalType, length: NoteLength, atHorizontalPosition xPosition: CGFloat, forcedDirection: NoteFlagDirection?) {
        let noteLayer = MusicStaffViewElementLayer(type: .note(name, accidental, length))
        
        var accidentalLayer: MusicStaffViewElementLayer?

        noteLayer.height = 4.0 * spaceWidth
        noteLayer.position = CGPoint(x: xPosition + noteLayer.bounds.size.width / 2.0, y: self.bounds.size.height)
        
        let offset = offsetForNote(name, octave: octave, clef: displayedClef)
        let viewOffset = viewOffsetForStaffOffset(offset)
        noteLayer.position.y += viewOffset
        
        if accidental != .none {
            accidentalLayer = MusicStaffViewElementLayer(type: .accidental(accidental))
            accidentalLayer?.height = 0.70 * 4.0 * spaceWidth
            accidentalLayer?.position = CGPoint(x: xPosition, y: self.bounds.size.height + viewOffset)
            staffLayer.addSublayer(accidentalLayer!)
            noteLayer.position.x += accidentalLayer!.bounds.width
        }
        
        var direction = (noteLayer.position.y > (self.bounds.size.height / 2.0)) ? NoteFlagDirection.down : NoteFlagDirection.up
        if forcedDirection != nil {
            direction = forcedDirection!
        }
        
        //do we need ledger lines?
        //this is a get-it-working approach
        var ledgerLines: CAShapeLayer?
        if let ledger = ledgerLinesForOffset(offset) {
            ledgerLines = CAShapeLayer()
            ledgerLines!.bounds = CGRect(x: 0, y: 0, width: noteLayer.bounds.size.width - 2.0, height: staffLayer.lineWidth * 2.0)
            ledgerLines!.backgroundColor = UIColor.black.cgColor
            ledgerLines!.position.y += noteLayer.anchorPoint.y * noteLayer.bounds.size.height
            ledgerLines!.position.x += noteLayer.anchorPoint.x * noteLayer.bounds.size.width
            
            if !ledger.centered {
                ledgerLines!.position.y += (direction == .up) ? spaceWidth / 2.0 : -spaceWidth / 2.0
            }
            
            ledgerLines!.strokeColor = UIColor.black.cgColor
            noteLayer.addSublayer(ledgerLines!)
        }

        //default direction is up
        if direction == .down {
            noteLayer.transform = CATransform3DIdentity
        } else {
            noteLayer.transform = CATransform3DMakeRotation(CGFloat(M_PI), 0, 0, 1.0)
        }
        
        if debug {
            noteLayer.backgroundColor = UIColor(red: 0, green: 0, blue: 1.0, alpha: 0.3).cgColor
            ledgerLines?.backgroundColor = UIColor.green.cgColor
            accidentalLayer?.backgroundColor = UIColor(red: 0, green: 1.0, blue: 1.0, alpha: 0.3).cgColor
        }
        
        staffLayer.addSublayer(noteLayer)
    }
    
    ///Calculates the offset for each note in a given clef
    ///
    ///Since notes need to be draw in the correct place in the y-axis, the offset from a given starting location must be computed. Currently, the zero-offset corresponds to the note one ledger line below the lowest staff line (aka Middle C in Treble Clef).
    ///
    ///The offset for the note specifies an offset from the center of the view.
    func offsetForNote(_ name: NoteName, octave: Int, clef: ClefType) -> Int {
        var offset: Int = 0
        var clefOctave: Int
        
        switch displayedClef {
        case .treble:
            //middle line of treble clef is B4
            //offset of zero corresponds to B4
            //the clef octave zeroes out the clef and the offset should be set to the positive offset of the note
            clefOctave = 4
            offset += NoteName.b.rawValue
        case .bass:
            clefOctave = 3
            offset += NoteName.d.rawValue
        case .alto:
            clefOctave = 4
        case .tenor:
            clefOctave = 4
        }
        
        if name == .a || name == .b {
            clefOctave += 1
        }
        
        let octaveOffset = 7 * (clefOctave - octave)
        offset -= name.rawValue - octaveOffset
        
        return offset
    }
    
    func viewOffsetForStaffOffset(_ offset: Int) -> CGFloat {
        let offsetFloat = CGFloat(offset)
        return -self.bounds.size.height / 2.0 + offsetFloat * spaceWidth / 2.0
    }
    
    /*
    ///Returns the number of ledger lines for a note in the given octave and clef
    ///
    ///Often times, notes will be drawn either below or above the five lines of the staff. Ledger lines are drawn onto the note layer and will always need to be drawn towards the center of the staff.
    ///
    ///- parameter name: The name of the note
    ///- parameter octave: The octave of the note
    ///- parameter clef: The type of clef
    ///- returns: The number of ledger lines and wheter the note resides on a line or between two lines
    func ledgerLinesForNote(_ name: NoteName, octave: Int, clef: ClefType) -> (number: Int, offset: Bool) {
        let viewOffset = offsetForNote(name, octave: octave, clef: clef)
        
        return (0, false)
    }*/
    
    func ledgerLinesForOffset(_ offset: Int) -> (count: Int, centered: Bool)? {
        if abs(offset) < 6 {
            return nil
        }
    
        return ((abs(offset) - 4) / 2, offset % 2 == 0)
    }
        
    override func prepareForInterfaceBuilder() {
        self.setupLayers()
    }

}
