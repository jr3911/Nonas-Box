//
//  CookingCollectionViewCell.swift
//  Nonas Box
//
//  Created by Jason Ruan on 10/9/20.
//  Copyright © 2020 Jason Ruan. All rights reserved.
//

import UIKit

class CookingCollectionViewCell: UICollectionViewCell {
    
    // MARK: - UI Objects
    private lazy var recipeImageView: UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFill
        iv.clipsToBounds = true
        return iv
    }()
    
    private lazy var recipeNameLabel:  UILabel = { return UILabel(numLines: 1, fontName: .handwriting, fontSize: 20, alignment: .center )}()
    
    
    // MARK: - Properties
    var recipe: RecipeDetails! {
        didSet {
            configureCell(forRecipe: recipe)
        }
    }
    
    static var identifier: String {
        return String(describing: self)
    }
    
    
    // MARK: - Initializers
    override init(frame: CGRect) {
        super.init(frame: frame)
        clipsToBounds = true
        backgroundColor = .systemBackground
        layer.cornerRadius = 10
        setUpViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    // MARK: - Private Methods
    private func setUpViews() {
        contentView.addSubview(recipeImageView)
        recipeImageView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            recipeImageView.topAnchor.constraint(equalTo: topAnchor),
            recipeImageView.leadingAnchor.constraint(equalTo: leadingAnchor),
            recipeImageView.trailingAnchor.constraint(equalTo: trailingAnchor),
            recipeImageView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
        
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = [UIColor.clear.cgColor, UIColor.clear.cgColor, #colorLiteral(red: 0.00280471798, green: 0.2107150853, blue: 0.412620753, alpha: 0.5).cgColor]
        gradientLayer.frame = bounds
        recipeImageView.layer.addSublayer(gradientLayer)
        
        contentView.addSubview(recipeNameLabel)
        recipeNameLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            recipeNameLabel.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.3),
            recipeNameLabel.leadingAnchor.constraint(equalTo: leadingAnchor),
            recipeNameLabel.trailingAnchor.constraint(equalTo: trailingAnchor),
            recipeNameLabel.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
        
        layoutIfNeeded()
    }
    
    private func configureCell(forRecipe recipe: RecipeDetails) {
        recipeNameLabel.text = recipe.title
        recipeImageView.kf.setImage(with: recipe.imageURL,
                                    placeholder: UIImage(systemName: "questionmark"),
                                    options: [.onFailureImage(UIImage(systemName: "xmark.rectangle.fill"))])
                                    { [weak self] (result) in
                                        switch result {
                                            case .failure:
                                                self?.recipeImageView.contentMode = .scaleAspectFit
                                            case .success:
                                                self?.recipeImageView.contentMode = .scaleAspectFill
                                        }
                                    }
    }
    
}

