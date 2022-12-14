//
//  ViewController2.swift
//  RescueFinder2
//
//  Created by 1 on 2022/09/01.
//

import Foundation
import UIKit

class ViewController2: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    let VC1 = KakaoMapView2()
    var rescues: [rescue] = []
    var hospitals: [hospital] = []
    var usr_lat: Double = 0
    var usr_lng: Double = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 8
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "ViewCell", for: indexPath) as? CustomCell else {
             return UITableViewCell()
         }
        if indexPath.row >= 5 {
            cell.Current_add.text = hospitals[indexPath.row - 5].name
            cell.from_distance.text = "거리: 약 \(hospitals[indexPath.row-5].distance)km"
            cell.Rescue_add.text = hospitals[indexPath.row-5].address
        } else {
            cell.Current_add.text = "응급구조함 \(indexPath.row + 1)"
            cell.from_distance.text = "거리: 약" + String(rescues[indexPath.row].distance) + "km"
            cell.Rescue_add.text = rescues[indexPath.row].address
        }
        
         return cell
    }
    
    // 테이블 뷰셀 높이 지정
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80.0
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
            //테이블뷰의 이벤트처리 함수
        var user_url = String(usr_lat) + "," + String(usr_lng)
        var destin_url: String = ""
        var total_url: String = ""
        if indexPath.row <= 5 {
            destin_url = String(rescues[indexPath.row].latitude) + "," + String(rescues[indexPath.row].longitude)
            total_url = "kakaomap://route?sp=\(user_url)&ep=" + destin_url + "&by=FOOT"
        } else {
            destin_url = String(hospitals[indexPath.row-5].latitude) + "," + String(hospitals[indexPath.row-5].longitude)
            total_url = "kakaomap://route?sp=" + user_url + "&ep=" + destin_url + "&by=FOOT"
        }
        print(total_url)
        
        if let openApp = URL(string: total_url), UIApplication.shared.canOpenURL(openApp) {
            if #available(iOS 10.0, *) {
                UIApplication.shared.open(openApp, options: [:], completionHandler: nil) }
            else { UIApplication.shared.open(openApp)}
            
        } else {
            if let openStore = URL(string: "itms-apps://itunes.apple.com/app/id304608425"), UIApplication.shared.canOpenURL(openStore) {
                if #available(iOS 10.0, *) {
                    UIApplication.shared.open(openStore, options: [:], completionHandler: nil)
                } else { UIApplication.shared.open(openStore) }
            }
        }
    }
}

class CustomCell: UITableViewCell {
    @IBOutlet var Current_add: UILabel!
    @IBOutlet var from_distance: UILabel!
    @IBOutlet var Rescue_add: UILabel!
    @IBOutlet var NaviBtn: UIButton!
}
