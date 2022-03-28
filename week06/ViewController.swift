//
//  ViewController.swift
//  week06
//
//  Created by 이보배 on 2022/03/23.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var days: UILabel!
    @IBOutlet weak var account: UILabel!
    
    @IBOutlet weak var msg: UILabel!
    
    @IBOutlet weak var paid: UIButton!
    @IBOutlet weak var bonus: UIButton!
    
    @IBOutlet weak var emp1: UIButton!
    @IBOutlet weak var emp2: UIButton!
    @IBOutlet weak var emp3: UIButton!
    
    @IBOutlet weak var img1: UIImageView!
    @IBOutlet weak var img2: UIImageView!
    @IBOutlet weak var img3: UIImageView!
    
    var plus = 100000
    var day = 1
    var money = 1000000
    var employees = 0
    var joindates = [0,0,0]
    var hp = [0,0,0]
    var spend: Double = 1000000
    var onoff: Bool = false
    let imgs = ["https://post-phinf.pstatic.net/MjAyMDA5MzBfNzYg/MDAxNjAxMzkzMzU3NDAy.cqLuKzwxumCmUKf0vHtU_8QxpjNLGoJZLsVxQDgHhAEg.Vuc1_1hFe1PtJ9_kuNyUeLCUT-3ZGlqtRpceXDsUnUcg.PNG/img-200929_01_15.png?type=w1200",
    "http://appdata.hungryapp.co.kr/data_file/data_img/201607/13/W14683947086778429.png/hungryapp/resize/500",
    "https://mblogthumb-phinf.pstatic.net/MjAxNzAyMjJfMTg3/MDAxNDg3NzI4NTQ2NjYz.PXKT8WOvIrVgUamJQqSIGdwjeUHlO6GKKQBJrcHejLsg.EgM4jWM1lZh3NGoC2BUgXQ2aFzqQnSCh8ivhMmT7wWUg.PNG.ioea65ztem/02.%EA%B5%AC%EA%B8%80.png?type=w800",
    "https://img.etoday.co.kr/pto_db/2015/09/600/20150919114509_715074_495_277.81250208395556.jpg"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
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
                }
                
                DispatchQueue.main.async {
                    
                    if self.day == 1 { self.msg.text = "당신은 그냥 한번 회사를 차려봤습니다" }
                    if self.day == 3 { self.msg.text = "우선은 직원을 채용해보는 게 좋겠네요" }
                    if self.day == 5 { self.msg.text = "일단 직원이 있어야 회사니까요" }

                    if self.day > 29 && self.day % 30 == 0 {
                        self.msg.text = "월급날입니다"
                    }
                }

                usleep(useconds_t(self.spend))
                day += 1
                spend = spend * 0.98

                if (onoff == true && self.money < 0) {
                    DispatchQueue.main.async {
                        self.account.text = String(self.money)
                        self.msg.text = "망했습니다"
                        onoff = false
                    }
                    break
                }
                
                if (onoff == true && employees == 0) {
                    DispatchQueue.main.async {
                        self.msg.text = "더 이상 일할 사람이 없는 것 같습니다."
                        onoff = false
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
        
        onoff = true
        
        let btntitle = btn.currentTitle ?? "채용"
        
        if (btntitle.contains("채용")) {
            if money < 1900000 {
                self.msg.text = "아무도 거지같은 회사에 오려하지 않습니다"
            } else {
                money -= 500000
                employees += 1
                hp[num] = 80
                joindates[num] = 0
                countingstart(btn, num)
                hpcheck(btn, num: num)
                switch(employees) {
                case 1: msg.text = "첫 번째 직원이 생겼습니다"
                case 2: msg.text = "두 번째 직원이 생겼습니다"
                case 3: msg.text = "세 번째 직원이 생겼습니다"
                default:
                    return
                }
                        
                btn.setTitle("내보내기", for: .normal)
        //      emp1.isEnabled = false
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
                self.msg.text = "임금 체불로 신고당했습니다."
                self.money -= 2000000
                self.plushp(-20)
            }
        }
    }
    
    func hpcheck(_ btn: UIButton, num: Int) {
        DispatchQueue.global().async {
            
            while(self.hp[num] >= 0) {
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
            }
        }
    }
}

