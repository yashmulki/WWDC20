//#-hidden-code
//
//  See LICENSE folder for this template’s licensing information.
//
//  Abstract:
//  The Swift file containing the source code edited by the user of this playground book.
//


import PlaygroundSupport

class MessageHandler: PlaygroundRemoteLiveViewProxyDelegate {
    public func remoteLiveViewProxyConnectionClosed(_ remoteLiveViewProxy: PlaygroundSupport.PlaygroundRemoteLiveViewProxy) {
    }
    
    public func remoteLiveViewProxy(_ remoteLiveViewProxy: PlaygroundSupport.PlaygroundRemoteLiveViewProxy, received message: PlaygroundSupport.PlaygroundValue) {
//        if case let .dictionary(dict) = message {
//            if case let .integer(pin) = dict["Pin"]! {
//
//            }
//        }
    }
    
    
}

guard let remoteView = PlaygroundPage.current.liveView as? PlaygroundRemoteLiveViewProxy else {
    fatalError("Always-on live view not configured in this page's LiveView.swift.")
}

var handler = MessageHandler()
remoteView.delegate = handler


class CRISPRInterface {
    
    func attachToDNA() {
        remoteView.send(.dictionary([type: "Attach"]))
    }
    
    func configureTarget(target: String) {
        remoteView.send(.dictionary([type: "Target", "Target": target]))
    }
    
    func configureTemplate(template: String) {
        remoteView.send(.dictionary([type: "Template", Template": template]))
    }
    
}

let crispr = CRISPRInterface()

//#-end-hidden-code

/*:

# Applying CRISPR
### Come up with something here

Now it's time to start using CRISPR!
 
The Swift bird has a problem; instead of it's normal orange/red gradient, it has mysteriously turned blue/purple. Fortunately, you just got your  Editor, a revolutionary new CRISPR system that lets you easily modify genes. Using the  Editor is simple – all you have to do is configure a "target" sequence, which is the sequence you are trying to cut out. Then, we can pass in a replacement sequence, and the DNA strand will use a process called Homology Directed Repair, which uses the provided replacement DNA to fill in the broken DNA strand with the new bases.
 
 The three base "codon" that codes for the bird's colour has two different configurations
 - ATG creates a blue/purple color, which is what the bird has right now
 - CTA creates an orange/red color, which is what the bird should have
 
*/

//: First,let's attach the CRISPR protein to our DNA strand
crispr.attachToDNA()

//: Second, let's configure the target DNA that we want to remove (ATG)
//crispr.configureTarget(target: "/*#-editable-code Target Sequence *//*#-end-editable-code*/")
//
////: Third, let's configure the template DNA (what we want to replace the target with) - should be CTA
//crispr.configureTemplate(template: /*#-editable-code Template Sequence *//*#-end-editable-code*/)

//: Now, we're ready to start editing. Run your code, then tap the play button on the top right of the editor screen

//#-hidden-code
var correctResults = [".*/ATG", ".*/TGG"]

// Validation stuff
public func findUserCodeInputs(from input: String) -> [String] {
    var inputs: [String] = []
    let scanner = Scanner(string: input)
    
    while scanner.scanUpTo(".*/", into: nil) {
        var userInput: NSString? = ""
        scanner.scanUpTo("/*#-end-editable-code", into: &userInput)
        
        if userInput != nil {
            inputs.append(String(userInput!))
        }
    }
    
    return inputs
}


public enum AssessmentResults {
    case pass(message: String)
    case fail(hints: [String], solution: String?)
}


public func makeAssessment(of input: String) -> PlaygroundPage.AssessmentStatus {
    let codeInputs = findUserCodeInputs(from: input)
    
    // validate the input; return .fail if needed
    if codeInputs[0] == correctResults[0] && codeInputs[1] == correctResults[1] {
        return .pass(message: "Great job! Move to the next page for more!")
    }
    return .fail(hints: ["The following hints contain the solution to each editable code area", "1", "2", "3", "1", "0.2", "2", "3", "2", "3"], solution: nil)
}

let input = PlaygroundPage.current.text
PlaygroundPage.current.assessmentStatus = makeAssessment(of: input)
//#-end-hidden-code

