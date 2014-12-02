import UIKit

class ImageSearchViewController: UIViewController {
    
    @IBOutlet var keywordField : UITextField!
    @IBOutlet var scalePctSlider : UISlider!
    @IBOutlet var resultImageView: UIImageView!
    @IBOutlet var navigationBar: UINavigationBar!
    
    let imgService:IImageService = ImageService(conf: "")
    var isPlaying:Bool = false
    var stopButton: UIBarButtonItem!
    var playButton: UIBarButtonItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        stopButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.Pause, target: self, action:Selector("showRandomImage"))
        playButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.Play, target: self, action:Selector("showRandomImage"))
        self.navigationItem.rightBarButtonItem = playButton
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func scalePercentageChanged(sender : AnyObject) {
        println("Percentage slider changed \(scalePctSlider.value)")
        
    }
    
    @IBAction func viewTapped(sender : AnyObject) {
        println("View tapped")
        keywordField.resignFirstResponder()
    }
    
    @IBAction func searchClicked(sender: AnyObject) {
        println("Search clicked")
        var imgView = imgService.searchImageFromGoogle!(keywordField.text)
        resultImageView.image = imgView
    }
    
    func showRandomImage() {
        var timer = NSTimer.scheduledTimerWithTimeInterval(5, target: self, selector: Selector("updateImage"), userInfo: nil, repeats: true)
        if(isPlaying){
            self.navigationItem.rightBarButtonItem = stopButton
        }
        else{
            self.navigationItem.rightBarButtonItem = playButton
        }
        isPlaying = !isPlaying
        println("is playing ... \(isPlaying)")
    }
    
    func updateImage(){
        println("searching for random image...")
        var imgView = imgService.searchImageFromGoogle!(keywordField.text)
        resultImageView.image = imgView
    }
}

