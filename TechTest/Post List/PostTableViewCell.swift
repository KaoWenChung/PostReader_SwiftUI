//
// Created by Alex Jackson on 01/03/2021.
//

import Foundation
import UIKit

final class PostTableViewCell: UITableViewCell {

    // MARK: - Public Properties

    @IBOutlet private(set) var titleLabel: UILabel!
    @IBOutlet private(set) var bodyLabel: UILabel!

    // MARK: - Public Methods

    func configure(with post: Post) {
        titleLabel.text = post.title
        bodyLabel.text = post.body
    }
}
