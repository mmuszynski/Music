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
        noteLayer.position.y += offset
        
        if accidental != .none {
            accidentalLayer = MusicStaffViewElementLayer(type: .accidental(accidental))
            accidentalLayer?.height = 0.70 * 4.0 * spaceWidth
            accidentalLayer?.position = CGPoint(x: xPosition, y: self.bounds.size.height + offset)
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
        
        if name == .c && octave != 5 {
            ledgerLines = CAShapeLayer()
            ledgerLines!.bounds = CGRect(x: 0, y: 0, width: noteLayer.bounds.size.width, height: staffLayer.lineWidth)
            ledgerLines!.backgroundColor = UIColor.black.cgColor
            ledgerLines!.position.y += noteLayer.anchorPoint.y * noteLayer.bounds.size.height
            ledgerLines!.position.x += noteLayer.anchorPoint.x * noteLayer.bounds.size.width
            ledgerLines!.strokeColor = UIColor.black.cgColor
            noteLayer.addSublayer(ledgerLines!)
        }
        
        if name == .b && octave != 4 {
            ledgerLines = CAShapeLayer()
            ledgerLines!.bounds = CGRect(x: 0, y: 0, width: noteLayer.bounds.size.width, height: staffLayer.lineWidth)
            ledgerLines!.backgroundColor = UIColor.black.cgColor
            ledgerLines!.position.y += noteLayer.anchorPoint.y * noteLayer.bounds.size.height
            ledgerLines!.position.y += (direction == .up) ? spaceWidth / 2.0 : -spaceWidth / 2.0
            ledgerLines!.position.x += noteLayer.anchorPoint.x * noteLayer.bounds.size.width
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
    func offsetForNote(_ name: NoteName, octave: Int, clef: ClefType) -> CGFloat {
        var offset: CGFloat = 0
        var clefOctave: Int = 0
        
        switch displayedClef {
        case .treble:
            clefOctave = 4
            offset = CGFloat(0.0)
        case .bass:
            offset = spaceWidth
            clefOctave = 3
        case .alto:
            offset = spaceWidth / CGFloat(2.0)
            clefOctave = 4
        case .tenor:
            clefOctave = 4
            offset = -spaceWidth / CGFloat(2.0)
        }
        
        if name == .a || name == .b {
            clefOctave -= 1
        }
        
        let octaveOffset = 7 * (octave - clefOctave)
        offset -= CGFloat(name.rawValue - octaveOffset) * spaceWidth / 2.0
        
        return offset
    }
    
    func ledgerLinesForNote(_ name: NoteName, octave: Int, clef: ClefType) -> (number: Int, offset: Bool) {
        //initially hardcoded for treble clef
        let offset = name.rawValue % 2 == 0
        
        return (0, offset)
    }
        
    override func prepareForInterfaceBuilder() {
        self.setupLayers()
    }

}
