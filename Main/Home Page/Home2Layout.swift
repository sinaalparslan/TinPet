
import UIKit

class Home2PagingCollectionViewLayout: UICollectionViewFlowLayout {

	private var velocityThresholdPerPage: CGFloat = 2
	private var numberOfItemsPerPage: CGFloat = 1

	override func targetContentOffset(forProposedContentOffset proposedContentOffset: CGPoint, withScrollingVelocity velocity: CGPoint) -> CGPoint {

		guard let collectionView = collectionView else { return proposedContentOffset }

		let pageLength: CGFloat
		let approxPage: CGFloat
		let currentPage: CGFloat
		let speed: CGFloat

		if scrollDirection == .horizontal {
			pageLength = (itemSize.width + minimumLineSpacing) * numberOfItemsPerPage
			approxPage = collectionView.contentOffset.x / pageLength
			speed = velocity.x
		} else {
			pageLength = (itemSize.height + minimumLineSpacing) * numberOfItemsPerPage
			approxPage = collectionView.contentOffset.y / pageLength
			speed = velocity.y
		}

		if speed < 0 {
			currentPage = ceil(approxPage)
		} else if speed > 0 {
			currentPage = floor(approxPage)
		} else {
			currentPage = round(approxPage)
		}

		guard speed != 0 else {
			if scrollDirection == .horizontal {
				return CGPoint(x: currentPage * pageLength, y: 0)
			} else {
				return CGPoint(x: 0, y: currentPage * pageLength)
			}
		}

		var nextPage: CGFloat = currentPage + (speed > 0 ? 1 : -1)

		let increment = speed / velocityThresholdPerPage
        if speed < 0 {
            nextPage += ceil(increment)
        } else {
            nextPage += floor(increment)
        }

		if scrollDirection == .horizontal {
			return CGPoint(x: nextPage * pageLength, y: 0)
		} else {
			return CGPoint(x: 0, y: nextPage * pageLength)
		}
	}
}
