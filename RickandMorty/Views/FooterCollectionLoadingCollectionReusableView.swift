//
//  FooterCollectionLoadingCollectionReusableView.swift
//  RickandMorty
//
//  Created by TTGMOTSF on 20/08/2023.
//

import UIKit

final class FooterCollectionLoadingCollectionReusableView: UICollectionReusableView {
    
    static let identfier = "FooterCollectionLoadingCollectionReusableView"
    
    private let spinner: UIActivityIndicatorView = {
        let spinner = UIActivityIndicatorView(style: .large)
        spinner.hidesWhenStopped = true
        spinner.translatesAutoresizingMaskIntoConstraints = false
        spinner.color = .white
        return spinner
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .clear
        addSubview(spinner)
        addConsstraints()
    }
    
    required init(coder: NSCoder) {
        fatalError("Unsupported")
    }
    
    private func addConsstraints() {
        NSLayoutConstraint.activate([
            spinner.widthAnchor.constraint(equalToConstant: 100),
            spinner.heightAnchor.constraint(equalToConstant: 100),
            spinner.centerXAnchor.constraint(equalTo: centerXAnchor),
            spinner.centerYAnchor.constraint(equalTo: centerYAnchor)
        ])
    }
    
    public func startAnimating() {
        spinner.startAnimating()
    }
}
