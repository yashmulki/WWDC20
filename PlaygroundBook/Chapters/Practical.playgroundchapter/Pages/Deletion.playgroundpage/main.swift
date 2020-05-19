//#-hidden-code
//
//  See LICENSE folder for this template’s licensing information.
//
//  Abstract:
//  The Swift file containing the source code edited by the user of this playground book.
//


import PlaygroundSupport
import Foundation

guard let remoteView = PlaygroundPage.current.liveView as? PlaygroundRemoteLiveViewProxy else {
    fatalError("Always-on live view not configured in this page's LiveView.swift.")
}

func attachToDNA() -> String {
    remoteView.send(.dictionary(["type": .string("Attach")]))
    return "Sent"
}

func configureTarget(target: String) {
    remoteView.send(.dictionary(["type": .string("Target"), "Target": .string(target.uppercased())]))
}

func configureTemplate(template: String) {
    remoteView.send(.dictionary(["type": .string("Template"), "Template": .string(template.uppercased())]))
}

//#-end-hidden-code

/*:
# Deletion with CRISPR
### Come up with something here

 Sometimes, we don't want to change a gene, but rather get rid of it entirely.
 
 Over the past few decades, climate change has radically transformed our climate and has become one of humanity's greatest threats. Fortunately, scientists have hypothesized applications of CRISPR that could help combat this issue by genetically engineering organisms to reduce or capture emissions of greenhouse gases.
 
 Methanogens (top-right) are microorganisms that produce methane as a metabolic byproduct. Unfortunately, methane is a potent greenhouse gas that contributes to climate change. Today, it is your task to delete a gene in the methanogen that increases the amount of methane production.
 
 To delete genes, scientists use CRISPR to cut out the targeted gene, but don't supply a template sequence. The DNA then uses Non Homologous repair, which is an error prone process that attempts to reconstruct the strand. In the process, the gene is effectively deleted.

 
*/

//: First,let's attach the CRISPR editor to our DNA strand
attachToDNA()

//: Second, let's configure the target DNA that we want to remove (AGA)
configureTarget(target: /*#-editable-code Sequence*/""/*#-end-editable-code*/)

//: Now, we're ready to start editing. Run your code, then tap the play button on the top right of the editor screen. The DNA will automatically try non homologous repair.

//#-hidden-code

var correctResults = ["Sequence*/\"AGA\""]


// Validation stuff
public func findUserCodeInputs(from input: String) -> [String] {
    var inputs: [String] = []
    let scanner = Scanner(string: input)

    while scanner.scanUpTo("Sequence*/", into: nil) {
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
    if codeInputs[0].uppercased() == correctResults[0].uppercased() {
        return .pass(message: "Great job! Hit the play button in the top right!")
    }
    return .fail(hints: ["The following hints contain the solution to each editable code area", "AAG"], solution: nil)
}

let input = PlaygroundPage.current.text
PlaygroundPage.current.assessmentStatus = makeAssessment(of: input)

//#-end-hidden-code

