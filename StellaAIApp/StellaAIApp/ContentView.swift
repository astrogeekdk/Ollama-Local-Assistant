import SwiftUI
import AVFoundation
import Speech



struct ContentView: View {
    
    @State private var inputText = ""
    @State private var text = ""

    
  var body: some View {
      
      VStack {
          TimelineView(.animation) {timeline in
              let x = (sin(timeline.date.timeIntervalSince1970) + 1) / 2
              Image(systemName: "circle.fill")
                  .font(.system(size: 100, weight: .black))
                  .foregroundStyle(
                    
                    MeshGradient(width: 3, height: 3, points: [
                        [0, 0], [0.5, 0], [1, 0],
                        [0, 0.5], [Float(x), 0.5], [1, 0.5],
                        [0, 1], [0.5, 1], [1, 1]
                    ], colors: [
                        .red, .red, .red,
                        .red, .orange, .red,
                        .red, .red, .red
                    ])
                    
                  )
              
          }
         
          
          Text("Hello there!")
              .font(.title3)
              .padding(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0))
          
          
          
          
            Image(systemName: "microphone")
              .resizable()
              .aspectRatio(contentMode: .fit)
              .frame(width: 20, height: 20)
              .padding(10)
              .background(.black.opacity(0.1))
              .cornerRadius(100)
              .onTapGesture {
                  print("Heyyy")
              }
            
          

          Text(text)
              .font(.callout)
              .frame(maxHeight: .infinity)
              .padding(EdgeInsets(top: 5, leading: 0, bottom: 0, trailing: 0))
          
          


              
          
          

          
          
          HStack {
              TextField("Enter something", text: $inputText)
                  .padding(10)
                  .background(.black.opacity(0.1))
                  .cornerRadius(100)
                  .textFieldStyle(PlainTextFieldStyle())
                  .overlay(
                    RoundedRectangle(cornerRadius: 100)
                        .stroke(.black.opacity(0.3), lineWidth: 1)
                  )
                  .frame(maxWidth: .infinity)
                  .onSubmit {
                      print(inputText)
                      text = inputText
                      inputText = ""
                     
                      fetchAPIResponse(prompt: text)
                      
                      
                  }
                
                  
              

              
                Image(systemName: "arrow.up")
                  .resizable()
                  .aspectRatio(contentMode: .fit)
                  .foregroundStyle(.white)
                  .frame(width: 10, height: 10)
                  .padding(10)
                  .background(.black.opacity(0.6))
                  .cornerRadius(100)
                  .overlay(
                    Circle()
                        .stroke(.black.opacity(0.1), lineWidth: 1)
                  )
                  .onTapGesture {
                      print("Heyyy")
                  }
                


            
              
          }
          
        
          
     
      }
      .frame(maxHeight: .infinity)
      .padding(20)
    
      
      
    
      
      
  }
    
    
    func fetchAPIResponse(prompt: String) {
           guard let url = URL(string: "http://localhost:11434/api/generate") else {
               print("Invalid URL")
               return
           }
           
           var request = URLRequest(url: url)
           request.httpMethod = "POST"
           request.setValue("application/json", forHTTPHeaderField: "Content-Type")
           
           // Prepare the request body
           let body: [String: Any] = [
            "system": "system message",
               "model": "llama3.2",
               "prompt": prompt,
               "stream": false
           ]
           
           do {
               let jsonData = try JSONSerialization.data(withJSONObject: body, options: [])
               request.httpBody = jsonData
           } catch {
               print("Error serializing JSON: \(error)")
               return
           }
           
           // Send the request
           let task = URLSession.shared.dataTask(with: request) { data, response, error in
               if let error = error {
                   print("Error making request: \(error)")
                   return
               }
               
               guard let data = data else {
                   print("No data received")
                   return
               }
               
               // Parse the response
               do {
                   if let jsonResponse = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any] {
                       if let responseText = jsonResponse["response"] as? String {
                           // Update UI on the main thread with the response
                           DispatchQueue.main.async {
                               text = responseText
                           }
                       } else {
                           print("Invalid response format")
                       }
                   }
               } catch {
                   print("Error parsing JSON response: \(error)")
               }
           }
           
           task.resume()
       }
    
    
}




#Preview {
    ContentView()
}
