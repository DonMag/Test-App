//
//  Copyright © 2020 Wael Saad - NetTrinity. All rights reserved.
//

import UIKit

class OnBoardingItemView: UICollectionViewCell {
    
    private enum Constants { }

    // MARK: properties
    
    //public var page: Page?
 
    private lazy var stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.spacing = 20
        stackView.axis = .vertical
        stackView.alignment = .center
        stackView.distribution = .equalSpacing
        stackView.spacing = UIStackView.spacingUseSystem
        stackView.isLayoutMarginsRelativeArrangement = true
        return stackView
    }()
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.preferredFont(forTextStyle: .title1)
        label.textColor = .black
        label.textAlignment = .center
        return label
    }()
    
    private lazy var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = #imageLiteral(resourceName: "Info")
        return imageView
    }()
    
    private lazy var descriptionLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.preferredFont(forTextStyle: .title3)
        label.numberOfLines = 0
        label.textColor = .black
        label.textAlignment = .center
        return label
    }()

    // MARK: View Life Cycle
    
//    init(with page: Page) {
//        //self.page = page
//        super.init(frame: .zero)
//    }

    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
    }

    // MARK: - Functions

    override func layoutSubviews() {
        super.layoutSubviews()
        layoutUI()
    }
    
    private func layoutUI() {
        
        stackView.addArrangedSubview(titleLabel)
        stackView.addArrangedSubview(imageView)
        stackView.addArrangedSubview(descriptionLabel)
        addSubview(stackView)
        
        stackView
            .layout
            .center(in: self)

        titleLabel
            .layout
            .top(to: self,
                 offset: 70)
            .size(120, 40)

        imageView
            .layout
            .below(titleLabel, offset: 10)
            .size(200, 150)

        descriptionLabel
            .layout
            .width(320)
    }

    func configureView(with page: Page) {
        titleLabel.text = page.title
        descriptionLabel.text = page.description
        backgroundColor = page.color
    }
}
