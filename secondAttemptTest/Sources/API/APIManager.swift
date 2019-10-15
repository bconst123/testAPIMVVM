
import Foundation

class APIManager {
    let stubDataURL = "https://url.com"

    
    func getAliasURL(_ link:String, completion: @escaping (_ resultCalc: LinkAliasType?, _ error: Error?) -> Void) {

        guard let url = URL(string: stubDataURL) else {
            print("Error: Cannot create URL from string")
            return
        }
        var urlRequest = URLRequest(url: url)
        let json: [String: Any] = ["url": "\(link)"]
        let jsonData = try? JSONSerialization.data(withJSONObject: json)
        
        urlRequest.httpBody = jsonData
        urlRequest.httpMethod = "POST"
        urlRequest.addValue("application/json", forHTTPHeaderField: "Content-Type")

        let task = URLSession.shared.dataTask(with: urlRequest) { (data, _, error) in
            guard error == nil else {
                print("Error calling api")
                return completion(nil, error)
            }
            guard let responseData = data else {
                print("Data is nil")
                return completion(nil, error)
            }
        
            do {
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                let resultCalc = try decoder.decode(LinkAliasType.self, from: responseData)
                return completion(resultCalc, nil)
            } catch let error {
                print("Error creating simulation from JSON because: \(error.localizedDescription)")
                return completion(nil, error)
            }
        }
        task.resume()
    }
}
