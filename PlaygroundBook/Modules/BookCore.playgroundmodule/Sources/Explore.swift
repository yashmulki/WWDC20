import UIKit
import PlaygroundSupport
import SceneKit
import QuickLook

//class HalfSizePresentationController : UIPresentationController {
//    override var frameOfPresentedViewInContainerView: CGRect {
//        guard let containerView = containerView else {
//            return CGRect(x: 0, y: 400, width: 250, height: 250)
//        }
//        return CGRect(x: containerView.bounds.width/2, y: 0, width: containerView.bounds.width/2, height: containerView.bounds.height)
//    }
//}

class MyViewController : UIViewController, PlaygroundLiveViewMessageHandler, PlaygroundLiveViewSafeAreaContainer, UIViewControllerTransitioningDelegate  {
    
    func receive(_ message: PlaygroundValue) {
        // Handle messages from the playground -- this is where configuration etc... goes
    }
//
//    func presentationController(forPresented presented: UIViewController, presenting: UIViewController?, source: UIViewController) -> UIPresentationController? {
//        return HalfSizePresentationController(presentedViewController: presented, presenting: presenting)
//    }
    
    var altController: UIViewController!

    override func viewDidLoad() {
        view.backgroundColor = .white
        
        let myFrame = CGRect(x: 0, y: 0, width: view.frame.width/2, height: view.frame.height)
        
        // Loading the image
        let background = UIImageView(image: UIImage(named: "background.jpeg"))
        background.frame = view.bounds.applying(CGAffineTransform(scaleX: 0.75, y: 1.5))
        view.addSubview(background)
        
        // Blur Effect
        let blurEffect = UIBlurEffect(style: UIBlurEffect.Style.regular)
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView.frame = view.bounds
        blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        view.addSubview(blurEffectView)
        
       
        let bacteriophageImage = UIImage(named: "Phage.png")!
        let bacteriophageFrame = CGRect(x: 20, y: 40, width: myFrame.width/2.2, height: myFrame.height/2.3)
        let bacteriophageCell = ItemCell(frameRect: bacteriophageFrame, title: "Bacteriophage", image: bacteriophageImage, model: "phage", detail: "A Virus", callback: { [self] in
            self.altController = ItemDetailViewController()
            self.altController.loadViewIfNeeded()
            //            self.navigationController!.pushViewController(self.altController, animated: true)
//            self?.present(controller, animated: true, completion: nil)
        })
        view.addSubview(bacteriophageCell)
        
        // Setup Cas9 protein
        let cas9Image = UIImage(named: "cnine.png")!
        let cas9Frame = CGRect(x: 40 + bacteriophageFrame.width, y: 40, width: myFrame.width/2.2, height: myFrame.height/2.3)
        let cas9Cell = ItemCell(frameRect: cas9Frame, title: "Cas 9 Protein", image: cas9Image, model: "cas9", detail: "A Cas9 Protein", callback: { [weak self] in
            self?.present(ItemDetailViewController(), animated: true, completion: nil)
        })
        view.addSubview(cas9Cell)
        // Setup bacteria
        let bacteriaImage = UIImage(named: "bacteria.png")!
        let bacteriaFrame = CGRect(x: 40 + bacteriophageFrame.width, y: cas9Cell.frame.height + 60, width: myFrame.width/2.2, height: myFrame.height/2.3)
        let bacteriaCell = ItemCell(frameRect: bacteriaFrame, title: "Bacteria", image: bacteriaImage, model: "cas9", detail: "A Bacteria", callback: { [weak self] in
            self?.present(ItemDetailViewController(), animated: true, completion: nil)
        })
        view.addSubview(bacteriaCell)
        
        // Setup DNA
        let DNAImage = UIImage(named: "DNA.png")!
        let DNAFrame = CGRect(x: 20, y: cas9Cell.frame.height + 60, width: myFrame.width/2.2, height: myFrame.height/2.3)
        let DNACell = ItemCell(frameRect: DNAFrame, title: "DNA Molecule", image: DNAImage, model: "DNA", detail: "A DNA Strand", callback: { [weak self] in
            self?.present(ItemDetailViewController(), animated: true, completion: nil)
        })
        view.addSubview(DNACell)
    }

    
}

class ItemCell: UIView {
    
    // Views
    private var label: UILabel
    private var imageView: UIImageView
    
    private var image: UIImage
    private var title: String
    private var model: String
    private var detail: String
    private var callback: () -> ()
    
    private let font = UIFont.systemFont(ofSize: 25, weight: .semibold)
    
    init(frameRect: CGRect, title: String, image: UIImage, model: String, detail: String, callback: @escaping () -> ()) {
    
        // Gather values
        self.image = image
        self.title = title
        self.model = model
        self.detail = detail
        self.callback = callback
        
        // Interface constants
        let width = frameRect.width
        let height = frameRect.height
        
        // Create Subviews
        label = UILabel(frame: CGRect(x: 0, y: 20, width: width, height: 44))
        imageView = UIImageView(frame: CGRect(x: width * 0.1, y: 80, width: width * 0.8, height: height * 0.7))
        imageView.contentMode = .scaleAspectFit
        imageView.backgroundColor = UIColor.clear
        imageView.image = image
        
        label.text = title
        label.textColor = UIColor.black
        label.textAlignment = .center
        label.font = font
        
        // Blur Background
        let blurEffect = UIBlurEffect(style: UIBlurEffect.Style.light)
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView.frame = CGRect(x: 0, y: 0, width: width, height: height)
        blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        blurEffectView.layer.cornerRadius = 15
        blurEffectView.layer.masksToBounds = true
        
        super.init(frame: frameRect)
    
        // Add subvies
        self.addSubview(blurEffectView)
        self.addSubview(label)
        self.addSubview(imageView)
        
        self.layer.cornerRadius = 15;
        self.layer.masksToBounds = true;
        
        // Gesture detection
        let tap = UITapGestureRecognizer(target: self, action: #selector(self.handleTap(_:)))
        self.addGestureRecognizer(tap)
        self.isUserInteractionEnabled = true
        
    }
    
    @objc func handleTap(_ sender: UITapGestureRecognizer) {
        DispatchQueue.main.async {
            self.callback()
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}



// Item popup with option to dismiss,a 3d view, a short description and
class ItemDetailViewController: UIViewController, QLPreviewControllerDataSource, PlaygroundLiveViewMessageHandler, PlaygroundLiveViewSafeAreaContainer  {
        
    private var message = "Cas-9 (CRISPR Associated) protein is the centerpiece of the CRISPR/Cas-9 genetic editing platform. The protein can take in a target RNA sequence which it then uses to find a corresponding DNA sequence on a strand. Once it finds the sequence, the protein can make a double stranded cut to break apart the target DNA"
    
    func numberOfPreviewItems(in controller: QLPreviewController) -> Int { return 1 }

       func previewController(_ controller: QLPreviewController, previewItemAt index: Int) -> QLPreviewItem {
           guard let path = Bundle.main.path(forResource: "cas9", ofType: "usdz") else { fatalError("Couldn't find the supported input file.") }
           let url = URL(fileURLWithPath: path)
           return url as QLPreviewItem
       }
    
    var scnView: SCNView!
    
     override func viewDidLoad() {
        view.backgroundColor = .red
        view.backgroundColor = .black

        // Load the 3D model into the scene view
        scnView = SCNView(frame: CGRect(x: 0, y: 0, width: view.frame.width/2, height: view.frame.height*0.7))
        guard let urlPath = Bundle.main.url(forResource: "cas9", withExtension: "usdz") else {
            print("Yikes")
            return
        }

        let referenceNode = SCNReferenceNode(url: urlPath)
        referenceNode?.load()
        referenceNode?.scale = SCNVector3(0.5, 0.5, 0.5)
        referenceNode!.runAction(SCNAction.repeatForever(SCNAction.rotateBy(x: 0, y: 2, z: 0, duration: 5)))

        let scene = SCNScene()
        let cameraNode = SCNNode()

        scene.rootNode.addChildNode(referenceNode!)

        cameraNode.camera = SCNCamera()
        cameraNode.position = SCNVector3(x: 0, y: 0, z: 100)
        scene.rootNode.addChildNode(cameraNode)

        let lightNode = SCNNode()

        lightNode.light = SCNLight()
        lightNode.light!.type = .directional
        lightNode.position = SCNVector3(x: 0, y: 60, z: 10)
        cameraNode.addChildNode(lightNode)

        let secondLightNode = SCNNode()

        secondLightNode.light = SCNLight()
        secondLightNode.light!.type = .directional
        secondLightNode.position = SCNVector3(x: 0, y: 60, z: 0)
        scene.rootNode.addChildNode(lightNode)


        let ambientLightNode = SCNNode()
        ambientLightNode.light = SCNLight()
        ambientLightNode.light!.intensity = 5000
        ambientLightNode.light!.type = .ambient
        ambientLightNode.light!.color = UIColor.darkGray
        scene.rootNode.addChildNode(ambientLightNode)


        scnView.scene = scene
        scnView.allowsCameraControl = true
        scnView.backgroundColor = UIColor.black


        view.addSubview(scnView)

        // Blur and desription label
        
        let descriptionView = UIView(frame: CGRect(x: 25, y: view.frame.height - 220, width: view.frame.width/2 , height: 150))
        descriptionView.backgroundColor = .clear
        descriptionView.layer.cornerRadius = 15
        descriptionView.clipsToBounds = true
        view.addSubview(descriptionView)
        
        // Blur Background
               let blurEffect = UIBlurEffect(style: UIBlurEffect.Style.extraLight)
               let blurEffectView = UIVisualEffectView(effect: blurEffect)
                blurEffectView.frame = descriptionView.frame
               blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
               blurEffectView.layer.cornerRadius = 15
               blurEffectView.layer.masksToBounds = true
        descriptionView.addSubview(blurEffectView)

        let descriptionLabel = UILabel(frame: descriptionView.frame)
        descriptionLabel.text = message
        descriptionLabel.numberOfLines = 10
        descriptionLabel.textColor = .black
        view.addSubview(descriptionLabel)
//
//        let closeButton = CustomButton(frame: CGRect(x: view.frame.width - 50, y: 20, width: 35, height: 35))
//        closeButton.configure(code: "multiply.circle.fill")
//        closeButton.addTarget(self, action: #selector(self.closeDetailView), for: .touchDown)
//        view.addSubview(closeButton)

        let arButton = CustomButton(frame: CGRect(x: view.frame.width/2 - 50, y: view.frame.height*0.7, width: 35, height: 35))
        arButton.configure(code: "cube.box.fill")
        arButton.addTarget(self, action: #selector(self.displayARView), for: .touchDown)
        view.addSubview(arButton)
        

    }
    
    @objc func closeDetailView() {
//        self.dismiss(animated: true, completion: nil)
    }
    
    @objc func displayARView() {
        let previewController = QLPreviewController()
        previewController.dataSource = self
        present(previewController, animated: true, completion: nil)
        
    }
    
}

class CustomButton: UIButton {
    
    func configure(code: String) {
        self.tintColor = .lightGray
        let imageView = UIImageView(image: UIImage(systemName: code))
        imageView.frame = self.bounds
        addSubview(imageView)

    }
}
