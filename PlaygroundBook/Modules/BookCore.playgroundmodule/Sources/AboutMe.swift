import SwiftUI

struct ContentView: View {
    var body: some View {
        VStack {
            HStack {
                Image("Yash1").resizable()
                VStack {
                    Image("Yash2").resizable()
                    Image("Oakville").resizable()
                }
                Image("Craig").resizable()
            }
            Text("👋 Hello! Thanks for viewing my playground. I'm Yash Mulki, a 17 year old student developer from the Town of Oakville in Canada. I learned how to code iOS apps back when Swift was released in 2014, and it's been a tremendously exciting journey since then. I've developed a variety of iOS apps, centered around the theme of improving political engagement and voter turnout. My latest app, Votisor, provides information on candidates, representatives and elections in Canada. I've also interned as an iOS developer at Tulip Retail, an Apple partnered company during the summer after grade 10 and 11 ").padding(EdgeInsets(top:120, leading: 50, bottom: 120, trailing: 50)).font(Font.system(size: 22, weight: .semibold, design: .default))
        }
    }
}
