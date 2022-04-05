import Foundation

class NetworkManager {
    
    public func fetchData<T:Decodable>(url: URL,
                                       dataHandler: @escaping (Result<T, Error>)->()) {
        URLSession.shared.dataTask(with: url) { (data, resp, err) in
            if let err = err {
                dataHandler(.failure(err))
            }
            
            guard let data = data else {
                dataHandler(.failure(ErrorsEnum.noDataFound("No data found.")))
                return
            }
            do {
                let obj = try JSONDecoder().decode(T.self, from: data)
                dataHandler(.success(obj))
            } catch let jsonError {
                dataHandler(.failure(ErrorsEnum.errorObteiningData(jsonError.localizedDescription)))
            }
        }.resume()
    }

}
