//
//  ViewController.swift
//  CurrencyConverterJsonAPI
//
//  Created by mac on 30.10.2020.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var cadLabel: UILabel!
    @IBOutlet weak var chfLabel: UILabel!
    @IBOutlet weak var gbpLabel: UILabel!
    @IBOutlet weak var jpyLabel: UILabel!
    @IBOutlet weak var usdLabel: UILabel!
    @IBOutlet weak var tryLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func getRatesClicked(_ sender: Any) {
        
        //ORDER for web request
        //1-Request (Session) URL'e gitmek
        //2-Response'u almak
        //3-Parsing or JSON Serialization
        //Step 1
        let url = URL(string: "http://data.fixer.io/api/latest?access_key=fb49c692b5bed4f1fd238bdb6917985a")
        
        let session = URLSession.shared
        //we do not continue after shared because to implement completion handler below
        
        //example of closure is below(Data , urlResponse and error) you use them in code section as variable
        let task = session.dataTask(with: url!) { (data, response, error) in
            
            if error != nil {
                
                let alert = UIAlertController(title: "Error", message: error?.localizedDescription, preferredStyle: UIAlertController.Style.alert)
                
                let okButton = UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil)
                alert.addAction(okButton)
                self.present(alert, animated: true, completion: nil)
            }
            else{
                //Step 2
                if data != nil {
                     
                    do {
                        
                    let jsonResponse = try JSONSerialization.jsonObject(with: data!, options: JSONSerialization.ReadingOptions.mutableContainers) as! Dictionary<String,Any>
                        //ASYNC thread
                        DispatchQueue.main.async {
                            if let rates = jsonResponse["rates"] as? [String : Any] {
                            
                                if let cad = rates["CAD"] as? Double {
                                    self.cadLabel.text = "CAD : \(cad)"
                                }
                                if let chf = rates["CHF"] as? Double {
                                    self.chfLabel.text = "CHF : \(chf)"
                                }
                                if let gbp = rates["GBP"] as? Double {
                                    self.gbpLabel.text = "GBP : \(gbp)"
                                }
                                if let jpy = rates["JPY"] as? Double {
                                    self.jpyLabel.text = "JPY : \(jpy)"
                                }
                                if let usd = rates["USD"] as? Double {
                                    self.usdLabel.text = "USD : \(usd)"
                                }
                                if let tl = rates["TRY"] as? Double {
                                    self.tryLabel.text = "TRY : \(tl)"
                                }
                        }
                        
                    }
                        
                    } catch{
                        print("response error")
                    }
                }
            }
        }
        //To start happenings above :D
        task.resume()
    }
}

