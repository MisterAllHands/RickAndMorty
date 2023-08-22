import Foundation
import SwiftUI
import Combine



class EpisodesManager: ObservableObject {
    @Published var episodes: [EpisodeCharacter] = []
    
    func fetchEpisodes() {
        
        // Modify the fetchEpisodes function to update the episodes array
        fetchEpisodes { result in
            switch result {
            case .success(let episodes):
                DispatchQueue.main.async {
                    self.episodes = episodes.results
                }
            case .failure(let error):
                print("Error fetching episodes: \(error)")
            }
        }
    }
    
    func fetchEpisodes(completion: @escaping (Result<EpisodeResults, Error>) -> Void) {
        let url = URL(string: "https://rickandmortyapi.com/api/episode")!
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            
            guard let data = data else {
                completion(.failure(NSError(domain: "DataError", code: 0, userInfo: nil)))
                return
            }
            
            do {
                let decoder = JSONDecoder()
                let episodes = try decoder.decode(EpisodeResults.self, from: data)
                completion(.success(episodes))
            } catch {
                completion(.failure(error))
            }
        }.resume()
    }
}
