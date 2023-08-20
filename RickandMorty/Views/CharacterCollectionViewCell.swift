//
//  CharacterCollectionViewCell.swift
//  RickandMorty
//
//  Created by TTGMOTSF on 18/08/2023.
//

import UIKit


///Single Cell for the Character
class CharacterCollectionViewCell: UICollectionViewCell {
    
    static let cellIdentifier = "CharacterCollectionViewCell"
    
    private let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 10
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private let nameLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont(name: "Kanit-SemiBold", size: 20)
        label.textAlignment = .center
        label.numberOfLines = 0
        return label
    }()
    
    private let statusLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = UIFont(name: "Kanit-SemiBold", size: 15)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    
    //MARK: - Init
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = UIColor(red: 0.15, green: 0.16, blue: 0.22, alpha: 1.0)
        self.layer.cornerRadius = 16.0
        contentView.backgroundColor = .clear
        contentView.addSubviews(imageView, nameLabel, statusLabel)
        addConstraint()
    }
    
    required init?(coder: NSCoder) {
        fatalError("Unsupported")
    }
    
    
    private func addConstraint() {
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
            imageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 8),
            imageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -8),
            imageView.heightAnchor.constraint(equalToConstant: 150),
            
            nameLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 4),
            nameLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 4),
            nameLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -4),
            nameLabel.bottomAnchor.constraint(equalTo: statusLabel.topAnchor, constant: 1),
            
            statusLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
            statusLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10),
            statusLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8),
        ])
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        imageView.image = nil
        nameLabel.text = nil
        statusLabel.text = nil
    }
    
    public func configure(with vm: CharacterCollectionCellViewModel) {
        
        nameLabel.text = vm.characterName
        let fullText = "Status: \(vm.characterStatus.rawValue)"
        let attributedText = NSMutableAttributedString(string: fullText, attributes: [
            .foregroundColor: UIColor.white
        ])
        
        // Define the range for the characterStatusText within the fullText
        if let range = fullText.range(of: vm.characterStatus.rawValue) {
            let start = fullText.distance(from: fullText.startIndex, to: range.lowerBound)
            let length = fullText.distance(from: range.lowerBound, to: range.upperBound)
            let textRange = NSRange(location: start, length: length)
            
            // Set the color for the characterStatusText
            attributedText.addAttribute(.foregroundColor, value: getStatusColor(for: vm.characterStatus), range: textRange)
        }
        
        // Apply the attributed text to the label
        statusLabel.attributedText = attributedText
        
        
        vm.fetchImage(completion: {[weak self] result in
            switch result {
            case .success(let data):
                DispatchQueue.main.async {
                    let image = UIImage(data: data)
                    self?.imageView.image = image
                }
            case .failure(let error):
                print(String(describing:error))
                break
            }
        })
    }
}

private func getStatusColor(for characterStatus: CharacterStatus) -> UIColor {
    
        switch characterStatus {
        case .alive:
            return .green
        case .dead:
            return .red
        case .unknown:
            return .yellow
        }
}
