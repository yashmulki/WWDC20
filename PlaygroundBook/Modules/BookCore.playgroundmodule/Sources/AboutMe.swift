import SwiftUI

struct ContentView: View {
    var body: some View {
        VStack {
            HStack {
                Image("Yash1").resizable().aspectRatio(contentMode: .fit)
                VStack {
                    Image("Craig").resizable().aspectRatio(contentMode: .fit)
                }
            }
            Text("👋 Hello! Thanks for viewing my playground. I'm Yash, a 17 year old student from Oakville, Canada. I learned how to code iOS apps back when Swift was released, and it's been a tremendously exciting journey. I've developed iOS apps focused on improving political engagement and voter turnout and have interned as an iOS developer at at an Apple partnered company during the summer after grades 10 and 11 ").padding(EdgeInsets(top:20, leading: 50, bottom: 0, trailing: 50)).font(Font.system(size: 22, weight: .semibold, design: .default))
        }
    }
}
