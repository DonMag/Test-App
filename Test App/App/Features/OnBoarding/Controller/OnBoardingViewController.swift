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
    
    
    // MARK: - Methods
    
    func configureView() {
        layoutSubViews()
        
        configureScrolling()
    }
    
    public func configureScrolling() {
        configureBoundaries()
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.01) {
            self.collectionView.reloadData()
            self.scroll(toElementAtIndex: 0)
            self.pageControl.setCurrentItem(index: 0)
        }
    }
    
    private func configureBoundaries() {
        itemsWithBoundries = viewModel.pages
        addLeadingItems()
        addTrailingItems()
    }
    
    private func addLeadingItems() {
        for index in stride(from: numberOfElements, to: 0, by: -1) {
            let indexToAdd = (viewModel.pages.count - 1) -
                ((numberOfElements - index) % viewModel.pages.count)
            let data = viewModel.pages[indexToAdd]
            itemsWithBoundries.insert(data, at: 0)
        }
    }
    
    private func addTrailingItems() {
        for index in 0..<numberOfElements {
            let data = viewModel.pages[index % viewModel.pages.count]
            itemsWithBoundries.append(data)
        }
    }
    
    public func scroll(toElementAtIndex index: Int) {
        let indexPath = IndexPath(item: index + numberOfElements,
                                  section: 0)
        collectionView.scrollToItem(at: indexPath,
                                    at: .left, animated: false)
    }
    
    private func layoutSubViews() {
        
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
        return itemsWithBoundries.count
        //return viewModel.pages.count
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard
            let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: reuseIdentifier,
                for: indexPath) as? OnBoardingItemView
        else { return UICollectionViewCell() }
        
		print(indexPath)
        cell.configureView(with: itemsWithBoundries[indexPath.row])
        //cell.configureView(with: viewModel.pages[indexPath.row])
        
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
        
		return()
        // Handle the infinite scrolling - Works Perfect
        
        let contentOffsetValue = scrollView.contentOffset.x
        if contentOffsetValue >= collectionView.contentSize.width - collectionView.frame.width {
            scrollView.contentOffset = CGPoint(x: collectionView.frame.width, y: 0)
        } else if contentOffsetValue <= 0 {
            let boundaryLessSize = CGFloat(viewModel.pages.count) *
                collectionView.bounds.size.width + CGFloat(viewModel.pages.count) - 5
            scrollView.contentOffset = CGPoint(x: boundaryLessSize, y: 0)
        }
        
        
        // Handle Check if Halfway into the next page and layout correctly - Works Perfect
        
        let width = scrollView.frame.size.width
        let x = scrollView.contentOffset.x
        let page = min(Int(round(x / width)), viewModel.pages.count)
        stylePageControlPerPage(page: page)
        currentIndex = page
        
        
        // THE ISSUE IS HERE: Handle Page Control Transition - Not Workin
        // This used to work perfectly when it was only 4 pages exactly
        
        let offset = scrollView.contentOffset.x
        pageControl.setCurrentItem(index: offset / width)
    }
}
