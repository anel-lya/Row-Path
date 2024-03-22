import UIKit

class SecondViewController: UIViewController {

    @IBOutlet weak var lbl: UILabel!
    @IBOutlet weak var activity: UIButton!
    @IBOutlet weak var back: UIButton!
    @IBOutlet weak var ind: UIActivityIndicatorView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        ind.stopAnimating()
        
    }
    
    @IBAction func get(_ sender: Any) {
        ind.startAnimating()
        lbl.isHidden = true
        back.isHidden = true
        activity.isHidden = true
        let tag = Int.random(in: 0...1)
        let str = (tag == 1) ? "https://api.quotable.io/random" : "https://www.boredapi.com/api/activity"
        Task{
            let url = URL(string: str)!
            let (data, _) = try! await URLSession.shared.data(from: url)
            var res = ""
            if (tag == 1) {
                res = (try! JSONDecoder().decode(Quote.self, from: data)).content
            }
            else {
                res = (try! JSONDecoder().decode(Activity.self, from: data)).activity
            }
            lbl.text = res
            ind.stopAnimating()
            lbl.isHidden = false
            back.isHidden = false
            activity.isHidden = false
        }
    }
}

class Activity : Codable {
    let activity : String!
}

class Quote : Codable {
    let content : String!
}
