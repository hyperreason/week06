//
//  ViewController.swift
//  week06
//
//  Created by 이보배 on 2022/03/23.
//

import UIKit
import Kingfisher

class ViewController: UIViewController {

    @IBOutlet weak var days: UILabel!
    @IBOutlet weak var account: UILabel!
    
    @IBOutlet weak var msg: UILabel!
    
    @IBOutlet weak var paid: UIButton!
    @IBOutlet weak var bonus: UIButton!
    
    @IBOutlet weak var emp1: UIButton!
    @IBOutlet weak var emp2: UIButton!
    @IBOutlet weak var emp3: UIButton!
    
    @IBOutlet weak var ownerimg: UIImageView!
    @IBOutlet weak var img1: UIImageView!
    @IBOutlet weak var img2: UIImageView!
    @IBOutlet weak var img3: UIImageView!
    
    var plus = 100000
    var day = 0
    var money = 1000000
    var employees = 0
    var joindates = [0,0,0]
    var hp = [0,0,0]
    var spend: Double = 1000000
    var onoff: Bool = false
    
    let url1 = URL(string: "https://mblogthumb-phinf.pstatic.net/MjAxNzAyMjJfMTg3/MDAxNDg3NzI4NTQ2NjYz.PXKT8WOvIrVgUamJQqSIGdwjeUHlO6GKKQBJrcHejLsg.EgM4jWM1lZh3NGoC2BUgXQ2aFzqQnSCh8ivhMmT7wWUg.PNG.ioea65ztem/02.%EA%B5%AC%EA%B8%80.png?type=w800")
    let url2 = URL(string: "https://itmoulds.com/media_cdn/images/content-froala/2020-05-18/ksr20/134309-1589776989590.jpg")
    let url3 = URL(string: "https://www.anewsa.com/news_images/2019/06/19/mark/2019061914091012914278835d09c376b30ab6.11882883.jpg")
    let url0 = URL(string: "https://post-phinf.pstatic.net/MjAyMDA5MzBfNzYg/MDAxNjAxMzkzMzU3NDAy.cqLuKzwxumCmUKf0vHtU_8QxpjNLGoJZLsVxQDgHhAEg.Vuc1_1hFe1PtJ9_kuNyUeLCUT-3ZGlqtRpceXDsUnUcg.PNG/img-200929_01_15.png?type=w1200")
    let close = URL(string: "https://cdn.gamemeca.com/data_center/192/382/20191013124203.jpg")
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        ownerimg.kf.setImage(with: url0)
        
        img1.alpha = 0.0
        img2.alpha = 0.0
        img3.alpha = 0.0
        img1.kf.setImage(with: url1)
        img2.kf.setImage(with: url2)
        img3.kf.setImage(with: url3)
        
        start()

    }

    
    func start() {
        
        DispatchQueue.global().async { [self] in
            
            while (1==1) {
                DispatchQueue.main.async {
                    let profit = self.profit()
                    self.money = self.money + (self.plus+profit)
                    self.account.text = String(self.money)
                    self.days.text = "DAY \(self.day)"
                    
                    if (self.employees == 3) {
                        UIView.animate(withDuration: 0.3, animations: {
                            self.img1.transform = CGAffineTransform(translationX: 0, y: -30)
                            self.img2.transform = CGAffineTransform(translationX: 0, y: -25)
                            self.img3.transform = CGAffineTransform(translationX: 0, y: -30)
                        })
                                
                        self.img1.transform = CGAffineTransform(translationX: 0, y: 0)
                        self.img2.transform = CGAffineTransform(translationX: 0, y: 0)
                        self.img3.transform = CGAffineTransform(translationX: 0, y: 0)
                    }
                }
                
                DispatchQueue.main.async {
                    
                    if self.day == 1 { self.msg.text = "당신은 그냥 한번 회사를 차려봤습니다" }
                    if self.day == 3 { self.msg.text = "우선은 직원을 채용해보는 게 좋겠습니다" }
                    if self.day == 5 { self.msg.text = "소개비가 비싸니 신중하세요" }

                    if self.day > 29 && self.day % 30 == 0 && self.employees > 0 {
                        self.msg.text = "월급날입니다"
                    }
                }
                

                usleep(useconds_t(self.spend))
                day += 1
                spend = spend * 0.98
                
                if (onoff == true && self.money < 0) {
                    DispatchQueue.main.async {
                        onoff = false
                        self.account.text = String(self.money)
                        self.msg.text = "망했습니다"
                        self.ownerimg.kf.setImage(with: close)
                        
                    }
                    break
                }
                
                if (onoff == true && employees == 0) {
                    DispatchQueue.main.async {
                        onoff = false
                        self.msg.text = "더 이상 일할 사람이 없는 것 같습니다."
                        self.ownerimg.kf.setImage(with: close)
                        
                    }
                    break
                }
                
                if (onoff == true && day > 5000) {
                    DispatchQueue.main.async {
                        onoff = false
                        
                        self.account.text = String(self.money)
                        self.msg.text = "당신은 이제 너무 늙었습니다. 세월이 야속하네요..."
                        self.ownerimg.kf.setImage(with: close)
                        
                        img1.isHidden = true
                        img2.isHidden = true
                        img3.isHidden = true
                        
                        
                    }
                    break
                }
            }
        }
    }
    
    func profit() -> Int {
        
        var result = 0
        
        for i in 0...2 {
            
            if (hp[i] == 0) {
                continue
            }
            
            result += hp[i] * 50000 / 100
                
        }
        
        return result

    }
    
    @IBAction func paid(_ sender: Any) {
        
        if employees == 0 {
            self.msg.text = "일단 사람을 쓰세요"
        } else if (money < employees * 1900000) {
            self.msg.text = "지금은 회사 사정이 어렵습니다. 다음에..."
            plushp(-5)
        } else {
            money -= employees * 1900000
            if (self.day < 30) {
                msg.text = "실수로 월급이 나갔지만 돌려받을 수 없습니다"
            } else {
                msg.text = "피같은 돈이 빠져나갑니다"
            }
            
            for var i in joindates {
                i -= 30
            }
 
        }
        
    }
    
    @IBAction func bonus(_ sender: Any) {
        
        if employees == 0 {
            self.msg.text = "회사돈은 개인돈이 아닙니다..."
        } else if (money < 1500000) {
            self.msg.text = "자금이 부족합니다."
        } else {
            money -= employees * 500000
            msg.text = "사무실 분위기가 좋아졌습니다"
            plushp(50)
        }
    }
    
    @IBAction func empaction1(_ sender: Any) {
        recruit(emp1, 0)
    }
    
    @IBAction func empaction2(_ sender: Any) {
        recruit(emp2, 1)
    }
    
    @IBAction func empaction3(_ sender: Any) {
        recruit(emp3, 2)
    }
    
    @IBAction func recruit(_ btn: UIButton, _ num: Int) {
        
        let btntitle = btn.currentTitle ?? "채용"
        
        if (btntitle.contains("채용")) {
            if money < 1900000 {
                self.msg.text = "아무도 거지같은 회사에 오려하지 않습니다"
            } else {
                onoff = true
                money -= 500000
                employees += 1
                hp[num] = 80
                joindates[num] = 0
                countingstart(btn, num)
                hpcheck(btn, num: num)
                switch(employees) {
                case 1: msg.text = "첫 번째 직원이 생겼습니다"
                case 2: msg.text = "두 번째 직원이 생겼습니다"
                case 3:
                    msg.text = "세 번째 직원이 생겼습니다"
                    plushp(10)
                default:
                    return
                }

                btn.setTitle("내보내기", for: .normal)
        //      emp1.isEnabled = false
                
                switch(num) {
                case 0:
                    img1.alpha = 1.0
                case 1:
                    img2.alpha = 1.0
                case 2:
                    img3.alpha = 1.0
                default:
                    return
                }
                
                if (employees == 3) {
                    
                    msg.text = "조금 회사다워졌어요!"
                    
                }
            }
                    
        } else {
            if employees == 1 {
                msg.text = "한 명이라도 있다는 사실에 감사하십시오."
            } else {
                employees -= 1
                msg.text = "직원들의 사기가 떨어진 것 같습니다..."
                plushp(-20)
                hp[num] = -1
                joindates[num] = -1
                btn.setTitle("채용", for: .normal)
                switch(num) {
                case 0:
                    img1.alpha = 0.0
                case 1:
                    img2.alpha = 0.0
                case 2:
                    img3.alpha = 0.0
                default:
                    return
                }
            }
                
        }

    }
    
    func plushp(_ point: Int) {
        for var i in hp {
            i += point
        }
    }
    
    func countingstart(_ btn: UIButton, _ num: Int) {
        
        DispatchQueue.global().async {
            
            while(self.joindates[num] < 50) {
                usleep(useconds_t(self.spend))
                self.joindates[num] += 1
            }
            DispatchQueue.main.async {
                print("a: \(self.joindates[0]), a: \(self.joindates[1]), a: \(self.joindates[2])")
                self.msg.text = "임금 체불로 신고당했습니다. 벌금이 나갑니다."
                self.money -= 2000000
                self.plushp(-20)
            }
        }
    }
    
    func hpcheck(_ btn: UIButton, num: Int) {
        DispatchQueue.global().async {
            
            while(self.hp[num] >= 0 && self.onoff == true) {
                usleep(useconds_t(self.spend*1.5))
                self.hp[num] -= 1
                
                if(self.hp[num] == 30) {
                    DispatchQueue.main.async {
                        self.msg.text = "직원이 우울해보입니다."
                    }
                }
            }
            
            DispatchQueue.main.async {
                btn.setTitle("채용", for: .normal)
                self.employees -= 1
                self.msg.text = "누군가 출근하지 않습니다..."
                self.plushp(-30)
                self.hp[num] = -1
                self.joindates[num] = -1
                switch(num) {
                case 0: self.img1.alpha = 0.0
                case 1: self.img2.alpha = 0.0
                case 2: self.img3.alpha = 0.0
                default: return
                }
            }
        }
    }
}

//extension UIImageView {
//    func setImage(with urlString: String) {
//        let cache = ImageCache.default
//        cache.retrieveImage(forKey: urlString, options: nil) { result in
//            switch result {
//            case .success(let value):
//                if let image = value.image {
//                    self.image = image
//                } else {
//                    guard let url = URL(string: urlString) else { return }
//                    let resource = ImageResource(downloadURL: url, cacheKey: urlString)
//                    self.kf.setImage(with: resource)
//                }
//            case .failure(let error):
//                print(error)
//            }
//        }
//    }
//}

