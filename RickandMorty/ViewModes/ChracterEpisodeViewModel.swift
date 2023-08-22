import Foundation
import SwiftUI
import Combine

struct EpisodeInfo: Codable {
    let count: Int
    let pages: Int
    let next: URL?
    let prev: URL?
}

struct EpisodeCharacter: Codable {
    let id: Int
    let name: String
    let air_date: String
    let episode: String
    let characters: [URL]
    let url: URL
    let created: String
}

struct EpisodeResults: Codable {
    let info: EpisodeInfo
    let results: [EpisodeCharacter]
}


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
