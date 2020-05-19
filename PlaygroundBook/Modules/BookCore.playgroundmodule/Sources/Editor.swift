import PlaygroundSupport
import SpriteKit
import AVFoundation

protocol Editable: SKSpriteNode {
    func setSequence(new: String)
    func editSequence(new: String)
    func setStrand(new: DNAStrand)
}

class Methanogen: SKSpriteNode, Editable {
    
    var sequence: String = ""
    var strand: DNAStrand?
    
    private var tadaPlayer: AVAudioPlayer?
    
    func setStrand(new: DNAStrand) {
        self.strand = new
    }
    
    func editSequence(new: String) {
        sequence = new
        print(new)
        if (new.contains("AGA")) {
            self.texture = SKTexture(imageNamed: "MethanogenBrown")
        } else  {
            tadaPlayer?.play()
            // Bounce animation
            let bounceFactor = 0.4
            let dropHeight = 0.2
            let dropAction = SKAction.move(by: CGVector(dx: 0, dy: -dropHeight*bounceFactor), duration: 0.3)
            let sequence = SKAction.sequence( [SKAction.move(by: CGVector(dx: 0, dy: dropHeight*bounceFactor), duration: 0.3),
                                               SKAction.move(by: CGVector(dx: 0, dy: -dropHeight*bounceFactor), duration: 0.3),
                                               SKAction.move(by: CGVector(dx: 0, dy: dropHeight*bounceFactor/2), duration: 0.3),
                                               SKAction.move(by: CGVector(dx: 0, dy: -dropHeight*bounceFactor/2), duration: 0.3)])
            
            sequence.timingMode = .easeInEaseOut
            
            let particles = SKEmitterNode(fileNamed: "Spark.sks")!
            particles.position = CGPoint(x: particles.position.x, y: 0)
            particles.setScale(0.005)
            particles.numParticlesToEmit = 500
            
            self.addChild(particles)
            
            let bounceEffect = SKAction.group([dropAction, sequence])
            self.texture = SKTexture(imageNamed: "MethanogenGreen")
            self.run(bounceEffect)
        }
    }
    
    func setSequence(new: String) {
        
        let tadaPath = URL(fileURLWithPath: Bundle.main.path(forResource: "tada", ofType: "mp3")!)
        do {
            tadaPlayer = try AVAudioPlayer(contentsOf: tadaPath)
        } catch  {
            print("error")
        }
        
        sequence = new
        guard let strand = strand else {
            return
        }
        strand.configureStrand(strand: new)
        
        if (new.contains("AGA")) {
            self.texture = SKTexture(imageNamed: "MethanogenBrown")
        } else  {
            self.texture = SKTexture(imageNamed: "MethanogenGreen")
        }
        
    }
}

class SwiftyBird: SKSpriteNode, Editable {
    
    var sequence: String = ""
    var strand: DNAStrand?
    private var tadaPlayer: AVAudioPlayer?
    
    func setStrand(new: DNAStrand) {
        self.strand = new
    }
    
    func editSequence(new: String) {
        sequence = new
        print(new)
        if (new.contains("ATG")) {
            self.texture = SKTexture(imageNamed: "SwiftPurple")
        } else  {
            tadaPlayer?.play()
            // Bounce animation
            let bounceFactor = 0.4
            let dropHeight = 0.2
            let dropAction = SKAction.move(by: CGVector(dx: 0, dy: -dropHeight*bounceFactor), duration: 0.3)
            let sequence = SKAction.sequence( [SKAction.move(by: CGVector(dx: 0, dy: dropHeight*bounceFactor), duration: 0.3),
                                               SKAction.move(by: CGVector(dx: 0, dy: -dropHeight*bounceFactor), duration: 0.3),
                                               SKAction.move(by: CGVector(dx: 0, dy: dropHeight*bounceFactor/2), duration: 0.3),
                                               SKAction.move(by: CGVector(dx: 0, dy: -dropHeight*bounceFactor/2), duration: 0.3)])
            
            sequence.timingMode = .easeInEaseOut
            
            let particles = SKEmitterNode(fileNamed: "Spark.sks")!
            particles.position = CGPoint(x: particles.position.x, y: 0)
            particles.setScale(0.005)
            particles.numParticlesToEmit = 500
            self.addChild(particles)
            
            let bounceEffect = SKAction.group([dropAction, sequence])
            self.texture = SKTexture(imageNamed: "SwiftBird")
            self.run(bounceEffect)
        }
    }
    
    func setSequence(new: String) {
        
        let tadaPath = URL(fileURLWithPath: Bundle.main.path(forResource: "tada", ofType: "mp3")!)
        do {
            tadaPlayer = try AVAudioPlayer(contentsOf: tadaPath)
        } catch  {
            print("error")
        }
        
        sequence = new
        guard let strand = strand else {
            return
        }
        strand.configureStrand(strand: new)
        
        if (new.contains("ATG")) {
            self.texture = SKTexture(imageNamed: "SwiftPurple")
        } else  {
            self.texture = SKTexture(imageNamed: "SwiftBird")
        }
        
    }
    
}

// Cas 9 Node
class Cas9Node: SKSpriteNode {
    
    var baseNodes: [SKSpriteNode]?
    var target: [Character]?
    var template: [Character]?
    var strand: DNAStrand?
    var audioPlayer: AVAudioPlayer?
    
    func attach(to strand: DNAStrand) {
        self.strand = strand
        //        let clickSoundPath = URL(fileURLWithPath: Bundle.main.path(forResource: "click", ofType: "wav")!)
        //              do {
        //                  audioPlayer = try AVAudioPlayer(contentsOf: clickSoundPath)
        //              } catch  {
        //                  print("error")
        //              }
        //
        // Play click sound
        
        let clickSoundPath = URL(fileURLWithPath: Bundle.main.path(forResource: "click", ofType: "wav")!)
        do {
            audioPlayer = try AVAudioPlayer(contentsOf: clickSoundPath)
        } catch  {
            print("error")
        }
        
        audioPlayer?.play()
        
        let strandMoveAction = SKAction.move(to: CGPoint(x: 0.425, y: 0.3), duration: 1.0)
        strandMoveAction.timingMode = .easeInEaseOut
        strand.run(strandMoveAction)
        
    }
    
    func loadTemplate(template: [Character]) {
        if template.count != 3 {
            return
        }
        
        if self.template != nil {
            self.template = nil
        }
        
        // Animate template coming in
        self.template = template
        
        for i in 0..<template.count {
            let base = template[i]
            var baseTexture = "C_Block.png"
            switch base {
            case Character("G"):
                baseTexture =  "G_Block.png"
            case Character("A"):
                baseTexture =  "A_Block.png"
            case Character("T"):
                baseTexture =  "T_Block.png"
            default:
                break
            }
            
            let baseNode = SKSpriteNode(imageNamed: baseTexture)
            baseNode.size = CGSize(width: 0.06, height: 0.06)
            baseNode.position = CGPoint(x: -0.5, y: -0.1355)
            
            
            let moveAction = SKAction.move(to: CGPoint(x: Double(i) * 0.074 -  0.075, y: -0.1355), duration: 1.0)
            moveAction.timingMode = .easeInEaseOut
            addChild(baseNode)
            baseNode.run(moveAction)
        }
        
    }
    
    func loadTarget(target: [Character]) {
        if target.count != 3 {
            return
        }
        
        
        if self.target != nil {
            self.template = nil
        }
        
        // Animate Target Coming in
        self.target = target
        
        for i in 0..<target.count {
            let base = target[i]
            var baseTexture = "C_Block.png"
            switch base {
            case Character("G"):
                baseTexture =  "G_Block.png"
            case Character("A"):
                baseTexture =  "A_Block.png"
            case Character("T"):
                baseTexture =  "T_Block.png"
            default:
                break
            }
            
            let baseNode = SKSpriteNode(imageNamed: baseTexture)
            baseNode.size = CGSize(width: 0.06, height: 0.06)
            baseNode.position = CGPoint(x: -0.5, y: 0.1355)
            
            let moveAction = SKAction.move(to: CGPoint(x: Double(i) * 0.074 -  0.075, y: 0.1355), duration: 1.0)
            moveAction.timingMode = .easeInEaseOut
            addChild(baseNode)
            baseNode.run(moveAction)
        }
        
        
    }
    
    func removeTargetCodon() {
        guard let target = self.target, let strand = self.strand else {
            return
        }
        
        // Get the correct position
        let position = strand.locationOfCodon(codon: target)
        
        // Move to the correct position ewith animation
        var offset = Double(position) * DNAStrand.basePairWidth
        if offset < 0 {
            offset = 0
            // Could prompt not found here
        }
        let moveAction = SKAction.move(by: CGVector(dx: CGFloat(-1.0 * offset), dy: 0), duration: 2)
        moveAction.timingMode = .easeInEaseOut
        strand.run(moveAction) {
            strand.deleteCodon(at: position, completion: { [weak self] in
                self?.strand?.repairCodon(at: position, template: nil)
            })
        }
        
        // Delete the codon and replace it with error prone repair
        //        strand.repairCodon(at: position, template: nil)
    }
    
    func removeTargetCodonAndReplace() {
        guard let target = self.target, let template = self.template, let strand = self.strand else {
            return
        }
        
        // Get the correct position
        let position = strand.locationOfCodon(codon: target)
        
        var offset = Double(position) * DNAStrand.basePairWidth
        if offset < 0 {
            offset = 0
            // Could prompt not found here
            return
        }
        let moveAction = SKAction.move(by: CGVector(dx: CGFloat(-1.0 * offset), dy: 0), duration: 2)
        moveAction.timingMode = .easeInEaseOut
        strand.run(moveAction) {
            strand.deleteCodon(at: position, completion: { [weak self] in
                self?.strand?.repairCodon(at: position, template: template)
            })
        }
        
    }
    
    
}

class GameScene: SKScene {
    
    // Graphics
    private var width: CGFloat!
    private var height: CGFloat!
    
    // DNA
    public var dnaNode: DNAStrand?
    
    // Cas9
    public var cas9Node: Cas9Node?
    
    // Editing target
    public var organism: Editable?
    
    private var bird = true
    
    override init(size: CGSize) {
        super.init(size: size)
    }
    
    init(bird: Bool) {
        super.init()
        self.bird = bird
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override func didMove(to view: SKView) {
        
        // Basic setup
        width = view.frame.width
        height = view.frame.height
        self.anchorPoint = CGPoint(x: 0.0, y: 0.0)
        
        // Set up background and add to scene
        let backgroundTexture = SKTexture(imageNamed: "Background-1.png")
        let backgroundNode = SKSpriteNode(texture: backgroundTexture, size: CGSize(width: 1, height: 1.33))
        backgroundNode.name = "Background"
        backgroundNode.position = CGPoint(x: 0.5, y: 0.5)
        self.addChild(backgroundNode)
        
        // Create Cas9 Node
        cas9Node = Cas9Node(imageNamed: "AppleEdit.png")
        self.addChild(cas9Node!)
        cas9Node!.size = CGSize(width: 0.45, height: 0.35)
        cas9Node?.position = CGPoint(x: 0.5, y: 0.35)
        
        // Create DNA Node
        dnaNode = DNAStrand()
        self.addChild(dnaNode!)
        dnaNode?.position = CGPoint(x: 1.1, y: 0.3)
        
        if (bird) {
            organism = SwiftyBird(texture: SKTexture(imageNamed: "SwiftPurple"))
            self.addChild(organism!)
            organism?.setStrand(new: dnaNode!)
            organism?.position = CGPoint(x: 0.5, y: 0.85)
            organism?.setSequence(new: "ATTAGCATAACGATGAA")
            organism?.size = CGSize(width: 0.3, height: 0.3)
            dnaNode?.setOrganism(new: organism!)
        } else {
            organism = Methanogen(texture: SKTexture(imageNamed: "MethanogenBrown"))
            self.addChild(organism!)
            organism?.setStrand(new: dnaNode!)
            organism?.position = CGPoint(x: 0.55, y: 0.85)
            organism?.setSequence(new: "AGTTTAAAGATCCGCCCT")
            organism?.size = CGSize(width: 0.4, height: 0.3)
            dnaNode?.setOrganism(new: organism!)
            
        }
    }
    
    func configureDNAStrand(with sequence: String) {
        
    }
    
}

class DNAStrand: SKNode {
    
    
    private var strand: [Character]?
    private var backgroundMusicPlayer: AVAudioPlayer?
    private var cutSoundPlayer: AVAudioPlayer?
    private var pairs: [BasePair] = []
    public static let basePairWidth = 0.08
    private var organism: Editable?
    
    func setOrganism(new: Editable) {
        organism = new
    }
    
    func deleteCodon(at: Int, completion: @escaping () -> ()) {
        
        if strand == nil {
            return
        }
        if at >= strand!.count {
            return
        }
        strand![at] = Character(".")
        
        // Play slicing sound
        cutSoundPlayer?.play()
        
        // Ask the basePairs to drop themselves
        pairs[at].drop(completion: nil)
        pairs[at+1].drop(completion: nil)
        pairs[at+2].drop(completion: completion)
        
    }
    
    func configureStrand(strand: String) {
        let backgroundMusicPath = URL(fileURLWithPath: Bundle.main.path(forResource: "EditorBackground", ofType: "mp3")!)
        do {
            backgroundMusicPlayer = try AVAudioPlayer(contentsOf: backgroundMusicPath)
        } catch  {
            print("error")
        }
        backgroundMusicPlayer?.play()
        
        let sliceSoundPath = URL(fileURLWithPath: Bundle.main.path(forResource: "slice", ofType: "wav")!)
        do {
            cutSoundPlayer = try AVAudioPlayer(contentsOf: sliceSoundPath)
        } catch  {
            print("error")
        }
        
        self.strand = Array(strand)
        for i in 0..<self.strand!.count {
            // Create a BasePair and add it in the right position
            let base = self.strand![i]
            let basePair = BasePair()
            basePair.configure(base: base)
            pairs.append(basePair)
            basePair.position = CGPoint(x: DNAStrand.basePairWidth * Double(i), y: 0)
            addChild(basePair)
        }
    }
    
    // Returns the location (index) of a specified codon - each index is X units in width
    func locationOfCodon(codon: [Character]) -> Int {
        cutSoundPlayer?.prepareToPlay()
        if codon.count != 3 {
            return -1
        }
        guard let strand = self.strand else {
            return -1
        }
        var index = -1
        for i in 0..<strand.count {
            print(i)
            if (i == strand.count - 2) {
                return index
            }
            if (strand[i] == codon[0] && strand[i+1] == codon[1] && strand[i+2] == codon[2]) {
                index = i
                return index
            }
        }
        return index
    }
    
    var bases = [Character("C"), Character("G"), Character("A"), Character("T")]
    
    func repairCodon(at: Int, template: [Character]?) {
        if strand == nil || at >= strand!.count - 2{
            return
        }
        var myTemplate = template
        if template == nil {
            myTemplate = [bases[Int(arc4random()%4)], bases[Int(arc4random()%4)], bases[Int(arc4random()%4)]]
        }
        
        // Update strand array
        strand![at] = myTemplate![0]
        strand![at+1] = myTemplate![1]
        strand![at+2] = myTemplate![2]
        
        // Create Base Pairs and Animate them in
        let firstBasePair = BasePair()
        firstBasePair.configure(base: myTemplate![0])
        pairs[at] = firstBasePair
        firstBasePair.position = CGPoint(x: DNAStrand.basePairWidth * Double(at-1), y: 0)
        self.addChild(firstBasePair)
        
        let secondBasePair = BasePair()
        secondBasePair.configure(base: myTemplate![1])
        pairs[at+1] = secondBasePair
        secondBasePair.position = CGPoint(x: DNAStrand.basePairWidth * Double(at-1), y: 0)
        self.addChild(secondBasePair)
        
        let thirdBasePair = BasePair()
        thirdBasePair.configure(base: myTemplate![2])
        pairs[at+2] = thirdBasePair
        thirdBasePair.position = CGPoint(x: DNAStrand.basePairWidth * Double(at-1), y: 0)
        self.addChild(thirdBasePair)
        
        let firstMoveAction = SKAction.move(to: CGPoint(x: DNAStrand.basePairWidth * Double(at), y: 0), duration: 0.5)
        firstMoveAction.timingMode = .easeInEaseOut
        
        let secondMoveAction = SKAction.move(to: CGPoint(x: DNAStrand.basePairWidth * Double(at+1), y: 0), duration: 0.6)
        secondMoveAction.timingMode = .easeInEaseOut
        
        let thirdMoveAction = SKAction.move(to: CGPoint(x: DNAStrand.basePairWidth * Double(at+2), y: 0), duration: 0.7)
        thirdMoveAction.timingMode = .easeInEaseOut
        
        
        
        firstBasePair.run(firstMoveAction) {
            secondBasePair.run(secondMoveAction) {
                thirdBasePair.run(thirdMoveAction) {
                    DispatchQueue.main.async {
                        self.organism?.editSequence(new: String(self.strand!))
                        
                    }
                }
                
            }
        }
        
        
    }
    
    
}

class BasePair: SKNode {
    
    func drop(completion: (() -> ())?) {
        let dropAction = SKAction.move(by: CGVector(dx: 0, dy: -0.6), duration: 0.8)
        dropAction.timingMode = .easeIn
        self.run(dropAction) {
            self.removeAllActions()
            self.removeFromParent()
            if let action = completion {
                action()
            }
        }
    }
    
    func configure(base: Character) {
        var topBaseTexture =  "Cytosine.png"
        var bottomBaseTexture = "Guanine.png"
        
        switch base {
        case Character("G"):
            topBaseTexture =  "Guanine.png"
            bottomBaseTexture = "Cytosine.png"
        case Character("A"):
            topBaseTexture =  "Adenine.png"
            bottomBaseTexture = "Thymine.png"
        case Character("T"):
            topBaseTexture =  "Thymine.png"
            bottomBaseTexture =  "Adenine.png"
        default:
            break
        }
        
        let topNode = SKSpriteNode(imageNamed: topBaseTexture)
        topNode.size = CGSize(width: 0.05, height: 0.08)
        topNode.position = CGPoint(x: 0, y: 0.1)
        self.addChild(topNode)
        
        let topStrandExtension = SKSpriteNode(color: UIColor.black, size: CGSize(width: 0.05 + DNAStrand.basePairWidth, height: 0.015))
        topStrandExtension.position = topNode.position.applying(CGAffineTransform(translationX: 0, y: -0.06))
        topNode.addChild(topStrandExtension)
        
        let bottomNode = SKSpriteNode(imageNamed: bottomBaseTexture)
        bottomNode.size = CGSize(width: 0.05, height: 0.08)
        bottomNode.position = CGPoint(x: 0, y: 0)
        bottomNode.zRotation = CGFloat.pi
        self.addChild(bottomNode)
        
        let bottomStrandExtension = SKSpriteNode(color: UIColor.black, size: CGSize(width: 0.05 + DNAStrand.basePairWidth, height: 0.015))
        bottomStrandExtension.position = bottomNode.position.applying(CGAffineTransform(translationX: 0, y: 0.04))
        bottomNode.addChild(bottomStrandExtension)
        
    }
    
}
class EditorViewController: UIViewController, PlaygroundLiveViewMessageHandler {
    
    private var sceneView: SKView?
    private var scene: GameScene?
    private var deletion = false
    private let feedback = UIImpactFeedbackGenerator()
    private var bird = true
    
    
    public func setMode(delete: Bool) {
        deletion = delete
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .black
        
        //  Configure spritekit view
        sceneView = SKView(frame: CGRect(x:0 , y:0, width: view.frame.width/2, height: view.frame.height))
        scene = GameScene(bird: bird)
        scene!.scaleMode = .aspectFill
        sceneView!.presentScene(scene!)
        view.addSubview(sceneView!)
        
        //         scene?.cas9Node?.attach(to: scene!.dnaNode!)
        //        scene?.cas9Node?.loadTarget(target: [Character("A"),Character("G"),Character("A")])
        //
        let runButton = CustomButton(frame: CGRect(x: view.frame.width/2 - 60, y: 20, width: 45, height: 45))
        runButton.configure(code: "play.circle.fill")
        runButton.addTarget(self, action: #selector(self.runCRISPR), for: .touchDown)
        view.addSubview(runButton)
    }
    
    
    init(bird: Bool) {
        super.init(nibName: nil, bundle: nil)
        self.bird = bird
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc func runCRISPR() {
        
        print("Hello world")
        guard let scene = self.scene, let crispr = scene.cas9Node else {
            return
        }
        feedback.impactOccurred()
        
        if (!bird) {
            crispr.removeTargetCodon()
        } else {
            crispr.removeTargetCodonAndReplace()
        }
    }
    
    
    public func receive(_ message: PlaygroundValue) {
        if case let .dictionary(text) = message {
            if case let .string(type) = text["type"]! {
                if type == "Attach" {
                    scene?.cas9Node?.attach(to: scene!.dnaNode!)
                } else if type == "Template" {
                    if case let .string(sequence) = text["Template"]! {
                        scene?.cas9Node?.loadTemplate(template: Array(sequence))
                    }
                } else if type == "Target" {
                    if case let .string(sequence) = text["Target"]! {
                        scene?.cas9Node?.loadTarget(target: Array(sequence))
                    }
                }
            }
        }
        
        
    }
    
}
