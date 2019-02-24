//
//  ViewController.swift
//  rechack
//
//  Created by 南田宗太郎 on 2019/02/23.
//  Copyright © 2019 南田宗太郎. All rights reserved.
//

import UIKit
import Alamofire


class ViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {

    

    @IBOutlet weak var genre: UIPickerView!
    @IBOutlet weak var musicname: UITextField!
    let genredataList = [
        "JPOP","JROCK","JAZ","KPOP",
        "POP","ROCK"
    ]
    var url : String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.musicname.delegate = self as? UITextFieldDelegate
        self.genre.delegate = self as? UIPickerViewDelegate
        let headers: HTTPHeaders = [
            "Contenttype": "application/json"
        ]

        let parameters:[String: Any] = [
            "genre": "username",
            "name": "password",
            "level":1
            
        ]
        Alamofire.request("https://dancemaker.herokuapp.com/api/test", method: .post, parameters: parameters, encoding: JSONEncoding.default, headers: headers).responseJSON { response in
            do {
                let response: RespomseData = try JSONDecoder.init().decode(RespomseData.self, from: response.data!)
                print(response.url)
                self.url = response.url
            } catch {
                print("error")
            }
        }
        
    }
    
    func textFieldShouldReturn(musicname: UITextField) -> Bool {
        musicname.resignFirstResponder()
        return true
    }
    
    func numberOfComponents(in genre : UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ genre: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return genredataList.count
    }
    
    
    
    
    func pickerView(_ genre: UIPickerView,
                    titleForRow row: Int,
                    forComponent component: Int) -> String? {
        
        return genredataList[row]
        
        self.performSegue(withIdentifier: "test", sender: 0)
    }
    
    @IBAction func submitButtonAction(_ sender: UIButton) {
        
        guard let _ = self.url else {return}
        
        
        self.performSegue(withIdentifier: "toVideoPlayer", sender: self.url)
        
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toVideoPlayer" {
            guard let VideoPlayerViewController = segue.destination as? VideoPlayerViewController else {return}
            guard let videoPath = sender as? String else {return}

            VideoPlayerViewController.url = videoPath
        }
    }
    /*
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        if (self.musicname.isFirstResponder()) {
            self.musicname.resignFirstResponder()
        }
    }
    */
    
    
}

struct RespomseData: Decodable {
    var url: String
    
    init(url: String) {
        self.url = url
    }
}
