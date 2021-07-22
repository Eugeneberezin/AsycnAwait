//
//  ContentView.swift
//  AsyncAwait
//
//  Created by Eugene Berezin on 7/19/21.
//

import SwiftUI

struct ContentView: View {
    @State private var uiImage = UIImage()
    @State private var isTextStackDisplayed = false
    @State private var description = ""
    @State private var imagesCount = 0
    
    var body: some View {
        VStack {
            Image(uiImage: uiImage)
                .resizable()
                .frame(width: 200, height: 200, alignment: .center)
            if isTextStackDisplayed {
                VStack(alignment:. leading) {
                    Text(description)
                        .lineLimit(nil)
                    Text("Images count: \(imagesCount)")
                }
                .font(.largeTitle)
            }
            Spacer()
        }
    }
    
    private func updateUI() async {
        do {
            if let image = try await uploadImage() {
                uiImage = image
            }
            
        } catch {
            print("Failed to upload image")
        }
        //
    }
    
    private func updateDescription() async -> String {
        "This is a logo image"
    }
    
    private func updateImageCount() async -> Int {
        1
    }
    
    private func uploadImage() async throws -> UIImage? {
        let url = URL(string: "https://opencollective-production.s3.us-west-1.amazonaws.com/97017710-a90f-11e9-b6fb-2bbe7128f780.png")!
        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            return UIImage(data: data)
            
        } catch {
            print("Failed to return image")
        }
        
        return nil
    }
    
    
}
    

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

