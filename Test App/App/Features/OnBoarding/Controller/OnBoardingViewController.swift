//
//  Copyright © 2020 Wael Saad - NetTrinity. All rights reserved.
//

import UIKit
import WWLayout

// MARK: Constants

private let reuseIdentifier = "OnBoardingItemView"

class OnBoardingViewController: UIViewController {
    
    // MARK: Properties

    fileprivate var numberOfElements = 1
    
    private var currentIndex: Int = 0
    
    private let viewModel = OnBoardingViewModel()
    
    fileprivate(set) public var itemsWithBoundries: [Page] = []
    
    private lazy var layout: UICollectionViewFlowLayout = {
        let layout = UICollectionViewFlowLayout()
        layout.sectionInset = .zero
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        layout.scrollDirection = .horizontal
        return layout
    }()
    
    private lazy var collectionView: UICollectionView = {
        let view = UICollectionView(frame: CGRect.zero,
                                    collectionViewLayout: layout)
        //view.bounces = false
        view.delegate = self
        view.delegate = self
        view.dataSource = self
        view.isPagingEnabled = true
        view.contentInset = .zero
        view.alwaysBounceHorizontal = false
        view.showsVerticalScrollIndicator = false
        view.showsHorizontalScrollIndicator = false
        view.register(OnBoardingItemView.self,
                      forCellWithReuseIdentifier: reuseIdentifier)
        
        return view
    }()
    
    private lazy var nextButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .yellow
        button.setTitleColor(.red, for: .normal)
        button.titleLabel?.font = UIFont.preferredFont(forTextStyle: .body)
        button.addTarget(self,
                         action: #selector(advanceTapped),
                         for: .touchUpInside)
        button.setTitle(viewModel.nextText, for: .normal)
        return button
    }()
    
    fileprivate(set) lazy var pageControl: PageControlView = {
        let pageControlView = PageControlView(frame: CGRect.zero)
        pageControlView.backgroundColor = .clear
        pageControlView.drawer = ExtendedDotDrawer(dotsColor: .red)
        pageControlView.numberOfPages = viewModel.pages.count
        return pageControlView
    }()
    
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        return [UIInterfaceOrientationMask.portrait]
    }
    
    override var shouldAutorotate: Bool {
        return true
    }
    
    // MARK: LifeCycle
    
    override func loadView() {
        super.loadView()
        view.addSubview(collectionView)
        view.addSubview(pageControl)
        view.addSubview(nextButton)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureView()
    }

	// we're going to set collection view number of items to 10,000
	//	so start at item 5,000
	override func viewDidAppear(_ animated: Bool) {
		super.viewDidAppear(animated)
		collectionView.scrollToItem(at: IndexPath(item: 5000, section: 0),
									at: .left, animated: false)
		self.pageControl.setCurrentItem(index: 0)
	}
    
    // MARK: - Methods
    
    func configureView() {
		// confusing to use layoutSubViews() (too close to layoutSubviews())
		//layoutSubViews()
		// so I changed it...
		layoutUIElements()
	}
    
    private func layoutUIElements() {
        
        collectionView
            .layout
            .fill(.superview)
        
        pageControl
            .layout
            .bottom(to: view,
                    offset: -20)
            .center(in: view,
                    axis: .x)
            .size(250, 50)

        nextButton
            .layout
            .height(60)
            .leading(to: view,
                     offset: 20)
            .trailing(to: view,
                      offset: -20)
            .bottom(to: view,
                    offset: -120)
    }
    
    func scrollViewWillEndDragging(_ scrollView: UIScrollView,
                                   withVelocity velocity: CGPoint,
                                   targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        let index = Int(targetContentOffset.pointee.x) / Int(scrollView.frame.width)
        currentIndex = index
    }
    
    // MARK: - User Actions
    
    @objc
    fileprivate func advanceTapped() {
		
        currentIndex += 1
        let indexPath = IndexPath(row: currentIndex,
                                  section: 0)
        collectionView.scrollToItem(at: indexPath,
                                    at: .centeredHorizontally, animated: true)
    }
    
    func stylePageControlPerPage(page: Int) {
        switch page {
        case 1:
            pageControl.color = .orange
            nextButton.backgroundColor = .orange
        default:
            pageControl.color = .gray
            nextButton.backgroundColor = .gray
        }
    }
}


extension OnBoardingViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView,
                        numberOfItemsInSection section: Int) -> Int {
		
		return 10000

	}
    
    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard
            let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: reuseIdentifier,
                for: indexPath) as? OnBoardingItemView
        else { return UICollectionViewCell() }

		// we are using 10,000 items, but only 4 "pages"
		//	so we cycle through them
		
		let idx = indexPath.item % viewModel.pages.count
		
		cell.configureView(with: viewModel.pages[idx])
		
        return cell
    }
}

extension OnBoardingViewController: UICollectionViewDelegate { }

extension OnBoardingViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        return collectionView.frame.size
    }
}

extension OnBoardingViewController: UIScrollViewDelegate {
    public func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
		let width = scrollView.frame.size.width
		let x = scrollView.contentOffset.x
		
		// the current cell / item number in the collection view
		let item = Int(round(x / width))
		
		// the page based on cell / item number
		let page = item % viewModel.pages.count
		
		stylePageControlPerPage(page: page)

		pageControl.setCurrentItem(index: CGFloat(page))

		// update currentIndex (for the next button)
		currentIndex = item

    }
}
