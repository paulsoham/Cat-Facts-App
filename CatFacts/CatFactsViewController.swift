//
//  CatFactsViewController.swift
//  CatFacts
//
//  Created by SOHAM PAUL on 25/01/25.
//

import Foundation
import UIKit

// MARK: - ViewController
class CatViewController: UIViewController {
    var viewModel = CatViewModel()
    
    let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.layer.cornerRadius = 10
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    let factLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.preferredFont(forTextStyle: .body)
        label.minimumScaleFactor = 0.5
        label.adjustsFontSizeToFitWidth = true
        label.textColor = .darkGray
        label.textAlignment = .center
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let activityIndicator: UIActivityIndicatorView = {
        let activityIndicator = UIActivityIndicatorView(style: .medium)
        activityIndicator.color = .systemBlue
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        return activityIndicator
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        Task {
            await viewModel.fetchCatContent()
            self.updateUI()
        }
    }
    
    func setupUI() {
        view.backgroundColor = .systemBackground
        
        view.addSubview(imageView)
        view.addSubview(factLabel)
        view.addSubview(activityIndicator)
        
        NSLayoutConstraint.activate([
            imageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            imageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            imageView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.8),
            imageView.heightAnchor.constraint(equalToConstant: 300),
            
            factLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            factLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            factLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 20),
            factLabel.bottomAnchor.constraint(lessThanOrEqualTo: view.bottomAnchor, constant: -20),
            factLabel.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.9),
       
            activityIndicator.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            activityIndicator.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(fetchCatContent))
        view.addGestureRecognizer(tapGesture)
        activityIndicator.startAnimating()
    }
    
    @objc private func fetchCatContent() {
        viewModel.isLoading = true
        activityIndicator.startAnimating()
        
        Task {
            await viewModel.fetchCatContent()
            self.updateUI()
        }
    }
    
    @MainActor
    func updateUI() {
        viewModel.isLoading = false
        activityIndicator.stopAnimating()
        
        if let errorMessage = viewModel.errorMessage {
            factLabel.text = errorMessage
            factLabel.textColor = UIColor.systemRed
            imageView.image = nil
        } else {
            factLabel.text = viewModel.catFact
            factLabel.textColor = UIColor.label
            if let image = viewModel.catImage {
                imageView.image = image
            }
        }
    }
}
