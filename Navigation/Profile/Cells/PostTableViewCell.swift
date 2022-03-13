//
//  PostTableViewCell.swift
//  Navigation
//
//  Created by Alex Alex on 13.03.2022.
//

import UIKit

class PostTableViewCell: UITableViewCell {

    struct PostViewModel: ViewModelProtocol {
        let author: String
        let description: String
        let image: String
        let likes: Int
        let views: Int
    }
    
    private lazy var backView: UIView = {
        let view = UIView()
        view.clipsToBounds = true
        view.layer.cornerRadius = 10
        view.layer.maskedCorners = [
            .layerMinXMinYCorner, .layerMaxXMinYCorner, .layerMinXMaxYCorner, .layerMaxXMaxYCorner
        ]
        view.backgroundColor = UIColor(hexString: "252525")
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 10
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    private lazy var authorLabel: UILabel = {
        let label = UILabel()
        label.backgroundColor = .clear
        label.numberOfLines = 0
        label.font = UIFont(name: "HelveticaNeue-CondensedBlack", size: 22)
        label.textColor = .white
        label.setContentCompressionResistancePriority(UILayoutPriority(1000), for: .vertical) // маскимально сопротивлялся сжатию
        label.setContentHuggingPriority(UILayoutPriority(1), for: .vertical) // при расширении минимальное сопротивлялся
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private lazy var descriptionLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.font = UIFont(name: "Georgia", size: 17)
        label.textColor = .white
        label.setContentCompressionResistancePriority(UILayoutPriority(250), for: .vertical) // сжатие
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var imageLabel: UILabel = {
        let label = UILabel()
        label.backgroundColor = .clear
        label.numberOfLines = 0
        label.font = UIFont(name: "HelveticaNeue-CondensedBlack", size: 22)
        label.textColor = .white
        label.setContentCompressionResistancePriority(UILayoutPriority(1000), for: .vertical) // маскимально сопротивлялся сжатию
        label.setContentHuggingPriority(UILayoutPriority(1), for: .vertical) // при расширении минимальное сопротивлялся
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    
    

//    private lazy var dateTitle: UILabel = {
//        let label = UILabel()
//        label.backgroundColor = .clear
//        label.font = UIFont.boldSystemFont(ofSize: 12)
//        label.textColor = .gray
//        label.setContentCompressionResistancePriority(UILayoutPriority(750), for: .vertical) // менее сжатие
//        label.translatesAutoresizingMaskIntoConstraints = false
//        return label
//    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        self.authorLabel.text = nil
        self.descriptionLabel.text = nil
        self.imageLabel.text = nil
    }
    
    private func setupView() {
        self.contentView.backgroundColor = .black

        self.contentView.addSubview(self.backView)
        self.backView.addSubview(self.stackView)
       // self.backView.addSubview(self.dateTitle)
       // self.stackView.addArrangedSubview(self.titleLabel)
       // self.stackView.addArrangedSubview(self.descriptionLabel)
        
        let backViewConstraints = self.backViewConstraints()
        let stackViewConstraints = self.stackViewConstraints()
        let dateTitleConstraints = self.dateTitleConstraints()

        NSLayoutConstraint.activate(
            backViewConstraints +
            stackViewConstraints +
            dateTitleConstraints)
    }
    
    private func backViewConstraints() -> [NSLayoutConstraint] {
        let topConstraint = self.backView.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: 10)
        let leadingConstraint = self.backView.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 20)
        let trailingConstraint = self.backView.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: -20)
        let bottomConstraint = self.backView.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor, constant: -10)

        return [
            topConstraint, leadingConstraint, trailingConstraint, bottomConstraint
        ]
    }
    
    private func stackViewConstraints() -> [NSLayoutConstraint] {
        let topConstraint = self.stackView.topAnchor.constraint(equalTo: self.backView.topAnchor, constant: 10)
        let leadingConstraint = self.stackView.leadingAnchor.constraint(equalTo: self.backView.leadingAnchor, constant: 10)
        let trailingConstraint = self.stackView.trailingAnchor.constraint(equalTo: self.backView.trailingAnchor, constant: -10)

        return [
            topConstraint, leadingConstraint, trailingConstraint
        ]
    }
    
    private func dateTitleConstraints() -> [NSLayoutConstraint] {
        let topConstraint = self.dateTitle.topAnchor.constraint(greaterThanOrEqualTo: self.stackView.bottomAnchor, constant: 10)  // больше или равен greaterThanOrEqualTo
        let leadingConstraint = self.dateTitle.leadingAnchor.constraint(equalTo: self.stackView.leadingAnchor)
        let trailingConstraint = self.dateTitle.trailingAnchor.constraint(equalTo: self.stackView.trailingAnchor)
        let bottomConstraint = self.dateTitle.bottomAnchor.constraint(equalTo: self.backView.bottomAnchor, constant: -10)

        return [
            topConstraint, leadingConstraint, trailingConstraint, bottomConstraint
        ]
    }
}

extension PostTableViewCell: Setupable {
    
    func setup(with postViewModel: ViewModelProtocol) {
        guard let postViewModel = postViewModel as? PostViewModel else { return }
        
        self.authorLabel.text = postViewModel.author
        self.descriptionLabel.text = postViewModel.description
        self.imageLabel.text = postViewModel.image
//        self.likes.words.count = postViewModel.likes
//        self.views.words.count = postViewModel.views
     
    }

}
