import UIKit

class OnboardingViewController: UIViewController, UIScrollViewDelegate {
    
    // MARK: - 변수 정의
    
    @IBOutlet var scrollView: UIScrollView!
    @IBOutlet var pageControl: UIPageControl!

    // MARK: - View에 들어갈 데이터
    
    var scrollWidth: CGFloat! = 0.0
    var scrollHeight: CGFloat! = 0.0
    
    var descs = ["5가지 컬러의 질문 중\n매일 1개의 질문에 답을 해요",
                 "자문자답을 통해\n현재 고민을 깊게 생각해봐요",
                 "질문카드 선택 빈도에 따라\n나의 컬러는 매번 달라져요",
                 "다른사람의 이야기에\n공감해보세요"]
    var imgs = ["onboarding1.png","onboarding2.png","onboarding3.png","onboarding4.png"]

    // get dynamic width and height of scrollview and save it
    override func viewDidLayoutSubviews() {
        scrollWidth = scrollView.frame.size.width
        scrollHeight = scrollView.frame.size.height
    }

    // MARK: - viewDidLoad, 텍스트, 이미지, 페이지컨트롤
    
    override func viewDidLoad() {
        super.viewDidLoad()
        super.viewDidLayoutSubviews()
        self.view.backgroundColor = UIColor(red: (247/255.0), green: (247/255.0), blue: (247/255.0), alpha: 1.0)
        self.view.layoutIfNeeded()
        
        self.navigationController?.navigationBar.topItem?.title = ""
        self.navigationController?.isNavigationBarHidden = true

        self.scrollView.delegate = self
        scrollView.isPagingEnabled = true
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.showsVerticalScrollIndicator = false

        // 슬라이드 만들고 추가하기
        var frame = CGRect(x: 0, y: 0, width: 0, height: 0)

        for index in 0..<imgs.count {
            frame.origin.x = scrollWidth * CGFloat(index)
            frame.size = CGSize(width: scrollWidth, height: scrollHeight)

            let slide = UIView(frame: frame)

            // subviews
            let imageView = UIImageView.init(image: UIImage.init(named: imgs[index]))
            imageView.frame = CGRect(x:0,y:0,width:325,height:547)
            imageView.contentMode = .scaleToFill
            imageView.center = CGPoint(x:scrollWidth/2,y: scrollHeight - imageView.frame.height/2)

            var yPosition: CGFloat = 100
            var fontSize: CGFloat = 24
            if scrollHeight < 800 {
                yPosition = imageView.frame.minY - 110
                fontSize = 20
            }

            let description = UILabel.init(frame: CGRect(x:0,y:yPosition,width:scrollWidth,height:70))
            description.numberOfLines = 2
            description.font = UIFont(name: "GmarketSansMedium", size: fontSize)
            description.text = descs[index]
            
            let attrString = NSMutableAttributedString(string: description.text!)
            let paragraphStyle = NSMutableParagraphStyle()
            paragraphStyle.lineSpacing = 15
            attrString.addAttribute(NSAttributedString.Key.paragraphStyle, value: paragraphStyle, range: NSMakeRange(0, attrString.length))
            if index == 0{
            attrString.addAttribute(.foregroundColor, value: UIColor(red: (31/255.0), green: (176/255.0), blue: (115/255.0), alpha: 1.0), range: (descs[index] as NSString).range(of:"5가지 컬러"))
            }
            else if index == 1{
            attrString.addAttribute(.foregroundColor, value: UIColor(red: (231/255.0), green: (79/255.0), blue: (152/255.0), alpha: 1.0), range: (descs[index]  as NSString).range(of:"현재 고민"))
            }
            else if index == 2{
            attrString.addAttribute(.foregroundColor, value: UIColor(red: (242/255.0), green: (82/255.0), blue: (82/255.0), alpha: 1.0), range: (descs[index]  as NSString).range(of:"달라져요"))
            }
            else if index == 3{
            attrString.addAttribute(.foregroundColor, value: UIColor(red: (159/255.0), green: (88/255.0), blue: (251/255.0), alpha: 1.0), range: (descs[index]  as NSString).range(of:"공감"))
            }
            description.attributedText = attrString
            description.textAlignment = .center

            slide.addSubview(imageView)
            slide.addSubview(description)
            scrollView.addSubview(slide)
            
            var constant: CGFloat = -20
            if scrollHeight < 800 {
                constant = -10
            }
            pageControl.bottomAnchor.constraint(equalTo: imageView.topAnchor
                       ,constant: constant).isActive = true
            
            // 마지막 페이지 버튼 추가
            let startButton = UIButton(frame: CGRect(x: scrollWidth/2-100, y: scrollHeight-144, width: 200, height: 50))
            
            startButton.backgroundColor =  UIColor(red: (34/255.0), green: (34/255.0), blue: (34/255.0), alpha: 1.0)
            startButton.layer.cornerRadius = 25
            
            startButton.setTitle("오늘의 나 시작하기   〉", for: .normal)
            startButton.setTitleColor(.white, for: .normal)
            startButton.titleLabel?.font = UIFont(name: "AppleSDGothicNeo-Bold", size: 16)
            startButton.addTarget(self, action: #selector(self.HomeButtonDidTapped(_:)), for: .touchUpInside)
            
            if index == 3 {
                slide.addSubview(startButton)
            }
        }

        // 모든 슬라이드를 수용하기 위한 scrollview의 width 설정
        scrollView.contentSize = CGSize(width: scrollWidth * CGFloat(imgs.count), height: scrollHeight)

        // disable vertical scroll/bounce
        self.scrollView.contentSize.height = 1.0

        // 페이지 컨트롤
        pageControl.numberOfPages = imgs.count
        pageControl.currentPage = 0
        pageControl.pageIndicatorTintColor = UIColor(red: (204/255.0), green: (204/255.0), blue: (204/255.0), alpha: 1.0)
        pageControl.currentPageIndicatorTintColor = .black
    }
        
    @objc
    public func HomeButtonDidTapped(_ sender: UIButton) {
        let sceneDelegate = UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate
        sceneDelegate?.isSceneDailyCheck()
    }

    // indicator
    @IBAction func pageChanged(_ sender: Any) {
        scrollView!.scrollRectToVisible(CGRect(x: scrollWidth * CGFloat ((pageControl?.currentPage)!), y: 0, width: scrollWidth, height: scrollHeight), animated: true)
    }

    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        setIndiactorForCurrentPage()
    }

    func setIndiactorForCurrentPage()  {
        let page = (scrollView?.contentOffset.x)!/scrollWidth
        pageControl?.currentPage = Int(page)
    }
}
