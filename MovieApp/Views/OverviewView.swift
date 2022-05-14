import UIKit
import PureLayout

class OverviewView: UIView {

    var overviewLabel: UILabel!
    var movieDescriptionLabel: UILabel!
    
    init() {
        super.init(frame: .zero)
        
        buildView()
        addConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func buildView() {
        overviewLabel = UILabel()
        overviewLabel.text = "Overview"
        overviewLabel.font = UIFont.init(name: "Proxima Nova", size: 20)
        overviewLabel.font = UIFont.boldSystemFont(ofSize: 20)
        addSubview(overviewLabel)
        
        movieDescriptionLabel = UILabel()
        movieDescriptionLabel.text = "After beeing held captive in an Afganistan cave, billionaire engineer Tony Stark creates a unique weaponized suit of armor to fight evil."
        movieDescriptionLabel.font = UIFont.init(name: movieDescriptionLabel.font.fontName, size: 14)
        movieDescriptionLabel.numberOfLines = 0
        addSubview(movieDescriptionLabel)
    }
    
    func addConstraints() {
        overviewLabel.autoPinEdge(toSuperviewEdge: .leading, withInset: 18)
        overviewLabel.autoPinEdge(toSuperviewEdge: .trailing, withInset: 18)
        overviewLabel.autoPinEdge(toSuperviewEdge: .top, withInset: 18)
        
        movieDescriptionLabel.autoPinEdge(.top, to: .bottom, of: overviewLabel, withOffset: 9)
        movieDescriptionLabel.autoPinEdge(toSuperviewEdge: .leading, withInset: 18)
        movieDescriptionLabel.autoPinEdge(toSuperviewEdge: .trailing, withInset: 18)
        movieDescriptionLabel.autoPinEdge(toSuperviewEdge: .bottom, withInset: 9)
    }
    
}
